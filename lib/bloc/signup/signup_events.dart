import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class ClickSignUp extends SignupEvent{
  String name;
  String rollno;
  String branch;
  String username;
  String password;
  String role;
  String hostel;
  String wing;
  String roomno;
  ClickSignUp(this.name,this.rollno,this.branch,this.username,this.password,this.role,this.hostel,this.wing,this.roomno);

  @override
  List<Object> get props => [name,rollno,branch,username,password,role,hostel,wing,roomno];
}