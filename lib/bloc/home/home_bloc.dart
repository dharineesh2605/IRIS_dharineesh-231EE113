import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_events.dart';
import 'home_state.dart';
import 'package:bloc/bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadUsers>((event, emit) async {
      try {
        final snapshot = await FirebaseFirestore.instance.collection('users').get();
        final users = snapshot.docs.map((doc) => doc.data()).toList();
        emit(HomeLoaded(users));
      } catch (e) {
        emit(HomeError('Failed to load users: ${e.toString()}'));
      }
    });




    }
  }






