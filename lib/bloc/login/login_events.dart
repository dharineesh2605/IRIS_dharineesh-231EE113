// import 'package:equatable/equatable.dart';
//
//
// abstract class LoginEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class LoginSubmitted extends LoginEvent {
//   final String email;
//   final String password;
//   final String role;
//
//   LoginSubmitted(this.email, this.password,this.role);
//
//   @override
//   List<Object> get props => [email, password,role];
// }


import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  final String role;

  LoginSubmitted(this.email, this.password, this.role);

  @override
  List<Object> get props => [email, password, role];
}

class SignupClicked extends LoginEvent {
  @override
  List<Object> get props => [];
}


