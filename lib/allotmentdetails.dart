import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllotmentDetails extends StatefulWidget {
  final String? hostelId;
  final String wing;
  final String room;

  AllotmentDetails({required this.hostelId, required this.wing, required this.room});

  @override
  _AllotmentDetailsState createState() => _AllotmentDetailsState();
}

class _AllotmentDetailsState extends State<AllotmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Allotment Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/userhome');
            },
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 120,top: 200),
          child: Column(
            children: [
              Text("Successfully Alloted Room",),

              Text('Hostel: ${widget.hostelId}'),
              Text('Wing: ${widget.wing}'),
              Text('Room: ${widget.room}'),



                ]),
        ),
    ));
  }
}