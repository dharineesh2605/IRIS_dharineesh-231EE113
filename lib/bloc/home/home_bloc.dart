import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_events.dart';
import 'home_state.dart';
import 'package:bloc/bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadUsers>((event, emit) async {
      try {
        final snapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get();



        final user=snapshot.data();
        emit(HomeLoaded(user!));
      } catch (e) {
        emit(HomeError('Failed to load users: ${e.toString()}'));
      }
    }
    );
    on<LoadUsersForAdmin>((event,emit) async{

        final adminsnapshot= await FirebaseFirestore.instance.collection("users").get();
        final users = adminsnapshot.docs.map((doc) => doc.data()).toList();
        emit(HomeLoadedAdmin(users));


    });




    }
  }







