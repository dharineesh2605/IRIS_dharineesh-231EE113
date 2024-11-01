import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_events.dart';
import 'package:iris_app/bloc/allotment/allotment_state.dart';
import 'package:iris_app/hostelwings.dart';

class Allotment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllotmentBloc()..add(LoadHostels()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Allotment'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/userhome');
              },
            ),
          ],
        ),
        body: BlocBuilder<AllotmentBloc, AllotmentState>(
          builder: (context, state) {
            if (state is AllotmentLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AllotmentError) {
              return Center(child: Text(state.message));
            } else if (state is AllotmentLoaded) {
              final hostels = state.hostels;

              return ListView.builder(
                itemCount: hostels.length,
                itemBuilder: (context, index) {
                  final hostel = hostels[index];

                  return ListTile(
                    title: Text('Hostel: ${hostel['name']}'),
                    subtitle: Text('Rooms Available: ${hostel['rooms']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        if (hostel['id'] != null && hostel['rooms'] > 0) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HostelWings(hostelId: hostel['id'])));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a valid hostel with available rooms')),
                          );
                        }
                      },
                      child: Text('Register'),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}