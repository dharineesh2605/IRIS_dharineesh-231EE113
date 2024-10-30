import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/bloc/signup/signup_bloc.dart';
import 'package:iris_app/bloc/signup/signup_events.dart';
import 'package:iris_app/bloc/signup/signup_state.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

Future<void> adduserdetails(
    String name,
    String branch,
    String rollno,
    String username,
    String password,
    String role,
    String hostel,
    String wing,
    String roomno) async {
  final userDoc = await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();
  if (userDoc.exists) {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "Name": name,
      "branch": branch,
      "roll no": rollno,
      "username": username,
      "password": password,
      "Role": role,
      "hostel": hostel,
      "wing": wing,
      "roomno": roomno,
    });
  } else {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      "Name": name,
      "branch": branch,
      "roll no": rollno,
      "username": username,
      "password": password,
      "Role": role,
      "hostel": hostel,
      "wing": wing,
      "roomno": roomno,
    });
  }
}

TextEditingController name = TextEditingController();
TextEditingController branch = TextEditingController();
TextEditingController rollno = TextEditingController();
TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController role = TextEditingController();

void cleartextfields() {
  name.clear();
  branch.clear();
  rollno.clear();
  username.clear();
  password.clear();
  role.clear();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("signup"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () =>
                    {Navigator.pushReplacementNamed(context, "/login")},
                child: Text("Return to login"))
          ],
        ),
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoaded && state.role == "user") {
              Navigator.pushReplacementNamed(context, "/userhome");
            } else if (state is SignUpLoaded && state.role == "admin") {
              Navigator.pushReplacementNamed(context, "/adminhome");
            }
          },
          child:
              BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
            if (state is SignUpLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: "name",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: branch,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              hintText: "branch",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: rollno,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              hintText: "roll no",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: username,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              hintText: "username",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: password,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              hintText: "password",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: role,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: "user/admin",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () => {
                                context.read<SignUpBloc>().add(ClickSignUp(
                                    name.text,
                                    rollno.text,
                                    branch.text,
                                    username.text,
                                    password.text,
                                    role.text,
                                    "Not alloted",
                                    "Not alloted",
                                    "Not alloted"))
                              },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 75, top: 15),
                              child: Text("SIGNUP"),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
