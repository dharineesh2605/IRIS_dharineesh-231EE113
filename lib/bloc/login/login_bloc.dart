import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_events.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading(email: event.email, password: event.password, role: event.role));
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final snapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get();
        if (event.role == "user" && snapshot.data()?["Role"] == "user") {
          emit(LoginUserSuccess(email: event.email, password: event.password, role: event.role));
        }
        else if(event.role == "admin" && snapshot.data()?["Role"] == "admin") {
      emit(LoginAdminSuccess(email: event.email, password: event.password, role: event.role));
      }// else {
         // emit(LoginFailure(email: event.email, password: event.password, role: event.role, error: "invalid credentials "));

      }
      catch (error) {
        emit(LoginFailure(email: event.email, password: event.password, role: event.role, error: error.toString()));
      }
    });

    on<SignupClicked>((event, emit) {
      emit(SignupRedirect());
    });
  }
}

