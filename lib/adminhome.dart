import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/home/home_events.dart';
import 'bloc/home/home_state.dart';


class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _HomeState();
}

class _HomeState extends State<Adminhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(" ADMIN PROFILE"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/requests');
            },
            child: Text("REQUESTS"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(LoadUsers()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {

              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else if (state is HomeLoaded) {
              return Container(child:
              Column(
                children: [
                  Expanded(

                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];

                        if (user['Role'] == 'user') {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20,left: 30),
                            child: Text(
                              'Name: ${user['Name'] ?? 'N/A'}\n'
                                  'Username: ${user['username'] ?? 'N/A'}\n'
                                  'Branch: ${user['branch'] ?? 'N/A'}\n'
                                  'Roll No: ${user['roll no'] ?? 'N/A'}\n'
                                  'Hostel: ${user['hostel'] ?? 'N/A'}\n'
                                  'Wing: ${user['wing'] ?? 'N/A'}\n'
                                  'Room No: ${user['room'] ?? 'N/A'}\n',
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),);
            } else {
              return const Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}