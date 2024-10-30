import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_state.dart';
import 'package:iris_app/signup.dart';
import 'bloc/home/home_events.dart';
import 'bloc/home/home_state.dart';
import 'login.dart';
import 'package:iris_app/bloc/home/home_bloc.dart';

class UserHome extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AllotmentBloc()),
        BlocProvider(create: (context) => HomeBloc()..add(LoadUsers())),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('USER PROFILE'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                cleartextfields();
                clearLoginTextfields();

                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else if (state is HomeLoaded) {
              return BlocBuilder<AllotmentBloc, AllotmentState>(
                  builder: (context, allotmentState) {
                if (allotmentState is AllotmentLoaded || state is HomeLoaded) {
                  return Container(
                      child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];


                      if (((user['username'] == username.text) ||
                          (user['username'] == email.text ))) {
                        return ListTile(
                          title: Container(

                            margin: EdgeInsets.only(top: 30, bottom: 20),
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration( color: Colors.blue.withOpacity(0.5)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 120, top: 30),
                              child: Text('Name: ${user['Name'] ?? 'N/A'}'),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 120, top: 30),
                                  child: Text(
                                      'branch: ${user['branch'] ?? 'N/A'}'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 100,
                                width: 400,
                                decoration: BoxDecoration(
                                  color:  Colors.blue.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 120, top: 30),
                                  child: Text(
                                      'roll no: ${user['roll no'] ?? 'N/A'}'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 100,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 120, top: 30),
                                  child: Text(
                                      'Hostel: ${user['hostel'] ?? 'Not alloted'}'),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                height: 100,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 120, top: 30),
                                  child: Text(
                                      'wing: ${user['wing'] ?? 'Not alloted'}'),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                height: 100,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 120, top: 30),
                                  child: Text(
                                      'room: ${user['room'] ?? 'Not alloted'}'),
                                ),
                              ),
                              (user['hostel'] == 'Not alloted'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                              context, "/allotment");
                                        },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 80, top: 20),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.blue),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                "Click here to register for Hostel"),
                                          ),
                                        ),
                                      ))
                                  : GestureDetector(
                                      onTap: () => {
                                        Navigator.pushReplacementNamed(
                                            context, "/changehostel")
                                      },
                                      child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 130, top: 20),
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  color: Colors.blue),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(top: 10),
                                                child: Text(
                                                    "Request Change"),
                                              ),
                                            ),
                                          )
                                      ),
                                    )
                              )],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ));
                } else {
                  return Container();
                }
              });
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}



