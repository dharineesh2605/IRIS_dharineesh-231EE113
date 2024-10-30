// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:iris_app/signup.dart';
//
// import '../../signup.dart';
// import 'signup_events.dart';
// import 'signup_state.dart';
// import 'package:bloc/bloc.dart';
//
// class SignUpBloc extends Bloc<SignupEvent,SignUpState>{
//   SignUpBloc():super(SignUpInitial()){
//   on<ClickSignUp>((event,emit) async{
//     emit(SignUpLoading());
//     try{
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: event.username, password: event.password);
//       await adduserdetails(event.name, event.branch, event.rollno, event.username, event.password,event.role,event.hostel);
//       emit(SignUpLoaded(event.name, event.rollno, event.branch, event.username, event.password,event.role));
//
//     }
//     catch(error){
//       emit(SignUpError(error.toString()));
//   }});
//
// }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iris_app/signup.dart';

import '../../signup.dart';
import 'signup_events.dart';
import 'signup_state.dart';
import 'package:bloc/bloc.dart';


class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<ClickSignUp>((event, emit) async {
      emit(SignUpLoading());
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.username,
          password: event.password,
        );
        await adduserdetails(
          event.name,
          event.branch,
          event.rollno,
          event.username,
          event.password,
          event.role,
          event.hostel,
          event.wing,
          event.roomno
        );
        await user.user?.reload();
        emit(SignUpLoaded(
          event.name,
          event.rollno,
          event.branch,
          event.username,
          event.password,
          event.role,
          event.wing,
          event.roomno
        ));
      } catch (error) {
        emit(SignUpError(error.toString()));
      }
    });
  }
}





