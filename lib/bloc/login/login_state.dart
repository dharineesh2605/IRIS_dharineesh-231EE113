// part of 'login_bloc.dart';
//
// abstract class LoginState extends Equatable {
//   final String email;
//   String password;
//   String role;
//
//   LoginState({required this.email, required this.password,required this.role});
//
//   @override
//   List<Object?> get props => [email, password,role];
// }
// class LoginInitial extends LoginState {
//   LoginInitial() : super(email: '', password: '',role: "");
// }
//
// class LoginLoading extends LoginState {
//
//   LoginLoading({required String email, required String password,required String role})
//       : super(email: email, password: password,role: role);
// }
//
// class LoginUserSuccess extends LoginState {
//   LoginUserSuccess({required String email, required String password,required String role})
//       : super(email: email, password: password, role: role);
// }
// class LoginAdminSuccess extends LoginState {
//   LoginAdminSuccess({required String email, required String password,required String role})
//       : super(email: email, password: password, role: role);
// }
//
// class LoginFailure extends LoginState {
//   final String error;
//
//   LoginFailure({required String email, required String password,required String role, required this.error})
//       : super(email: email, password: password,role: role);
//
//   @override
//   List<Object?> get props => [email, password, error];
// }

import 'package:equatable/equatable.dart';

import  'login_bloc.dart';

abstract class LoginState extends Equatable {
  final String email;
  String password;
  String role;

  LoginState({required this.email, required this.password, required this.role});

  @override
  List<Object?> get props => [email, password, role];
}

class LoginInitial extends LoginState {
  LoginInitial() : super(email: '', password: '', role: "");
}

class LoginLoading extends LoginState {
  LoginLoading({required String email, required String password, required String role})
      : super(email: email, password: password, role: role);
}

class LoginUserSuccess extends LoginState {
  LoginUserSuccess({required String email, required String password, required String role})
      : super(email: email, password: password, role: role);
}

class LoginAdminSuccess extends LoginState {
  LoginAdminSuccess({required String email, required String password, required String role})
      : super(email: email, password: password, role: role);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required String email, required String password, required String role, required this.error})
      : super(email: email, password: password, role: role);

  @override
  List<Object?> get props => [email, password, error];
}

class SignupRedirect extends LoginState {
  SignupRedirect() : super(email: '', password: '', role: '');
}






