import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable{
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState{}

class SignUpLoading extends SignUpState{}

class SignUpLoaded extends SignUpState{
  String name;
  String rollno;
  String branch;
  String username;
  String password;
  String role;
  String wing;
  String roomno;

  SignUpLoaded(this.name,this.rollno,this.branch,this.username,this.password,this.role,this.wing,this.roomno);
  List<Object> get props => [name,rollno,branch,username,password,role,wing,roomno];
}

class SignUpError extends SignUpState {
  String error;

  SignUpError(this.error);

  @override
  List<Object> get props => [error];
}

