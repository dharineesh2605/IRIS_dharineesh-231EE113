import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_events.dart';
import 'package:iris_app/bloc/allotment/allotment_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllotmentBloc extends Bloc<AllotmentEvent, AllotmentState> {
  AllotmentBloc() : super(AllotmentInitial()) {
    on<LoadHostels>((event, emit) async {
      emit(AllotmentLoading());
      try {
        final snapshot = await FirebaseFirestore.instance.collection("hostels")
            .get();
        final hostels = snapshot.docs.map((doc) {
          return {'id': doc.id, 'name': doc.data()['name'], 'rooms': doc.data()['rooms']};
        }).toList();
        emit(AllotmentLoaded(hostels));
      } catch (e) {
        emit(AllotmentError(e.toString()));
      }
    });



    on<ChangeHostelEvent>((event, emit) async {
      emit(AllotmentLoading());
      try {
        if (event.currentHostelId.isEmpty || event.newHostelId.isEmpty) {
          emit(AllotmentError("Hostel IDs cannot be empty."));
          return;
        }

        // Update the room count for the old hostel
        final oldHostelSnapshot = await FirebaseFirestore.instance.collection(
            "hostels").doc(event.currentHostelId).get();

        if (!oldHostelSnapshot.exists) {
          emit(AllotmentError("Old hostel not found."));
          return;
        }

        var currentRooms = oldHostelSnapshot.data()?['rooms'] ?? 0;
        await FirebaseFirestore.instance.collection("hostels").doc(
            event.currentHostelId).update({"rooms": currentRooms + 1});

        final newHostelSnapshot = await FirebaseFirestore.instance.collection(
            "hostels").doc(event.newHostelId).get();

        if (!newHostelSnapshot.exists) {
          emit(AllotmentError("New hostel not found."));
          return;
        }

        currentRooms = newHostelSnapshot.data()?['rooms'] ?? 0;
        if (currentRooms > 0) {
          await FirebaseFirestore.instance.collection("hostels").doc(
              event.newHostelId).update({"rooms": currentRooms - 1});
          final newWingData = newHostelSnapshot.data()?['wings'];
          final newRoomData = newHostelSnapshot.data()?['${event.newWing}'];

          if (newRoomData != null) {
            await FirebaseFirestore.instance.collection("hostels").doc(
                event.newHostelId).update({
              'wings.${event.newWing}': newWingData[event.newWing] - 1,
              '${event.newWing}.${event.newRoom}': false,
            });
          } else {
            emit(AllotmentError("New wing not found."));
          }
          await FirebaseFirestore.instance.collection("users").doc(
              FirebaseAuth.instance.currentUser?.uid).update(
              {"hostel": event.newHostelId, "wing": event.newWing, "roomno": event.newRoom});
          final newSnapshot = await FirebaseFirestore.instance.collection(
              "hostels").get();
          final hostels = newSnapshot.docs.map((doc) {
            return {'id': doc.id, 'name': doc['name'], 'rooms': doc['rooms']};
          }).toList();

          emit(AllotmentLoaded(hostels));
        } else {
          emit(AllotmentError("No rooms available in the new hostel."));
        }
      }
      catch (e) {
        emit(AllotmentError(e.toString()));
      }
    });

    on<H2RegisterEvent>((event, emit) async {
      emit(AllotmentLoading());
      try {
        final snapshot = await FirebaseFirestore.instance.collection("hostels")
            .doc(event.hostelId)
            .get();

        if (snapshot.exists) {
          var currentRooms = snapshot.data()?['rooms'] ?? 0;
          if (currentRooms > 0) {
            await FirebaseFirestore.instance.collection("hostels").doc(
                event.hostelId).update({"rooms": currentRooms - 1});
            await FirebaseFirestore.instance.collection("users").doc(
                FirebaseAuth.instance.currentUser?.uid).update(
                {"hostel": event.hostelId, "wing": event.wing, "room": event.room});
            final newSnapshot = await FirebaseFirestore.instance.collection(
                "hostels").get();
            final hostels = newSnapshot.docs.map((doc) {
              return {'id': doc.id, 'name': doc['name'], 'rooms': doc['rooms']};
            }).toList();

            emit(AllotmentLoaded(hostels));
          } else {
            emit(AllotmentError("No rooms available in this hostel."));
          }
        } else {
          emit(AllotmentError("Hostel not found."));
        }
      } catch (e) {
        emit(AllotmentError(e.toString()));
      }
    });
  }
}