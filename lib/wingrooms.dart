import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/allotmentdetails.dart';
import 'bloc/allotment/allotment_bloc.dart';


class WingRooms extends StatefulWidget {
  final String wing;
  final String? hostelId;

  WingRooms({required this.wing, required this.hostelId});

  @override
  WingRoomsState createState() => WingRoomsState();
}

class WingRoomsState extends State<WingRooms> {
  List<Widget> roomWidgets = [];

  @override
  void initState() {
    super.initState();
    fetchRoomData();
  }

  Future<void> fetchRoomData() async {
    final hostelDoc = await FirebaseFirestore.instance.collection('hostels').doc(widget.hostelId).get();
    final roomData = hostelDoc.data()?['${widget.wing}'];

    setState(() {
      roomWidgets = roomData.keys.map<Widget>((room) {
        return ListTile(
          title: Text(room),
          subtitle: Text(roomData[room] ? 'Available' : 'Occupied'),
          trailing: roomData[room]
              ? ElevatedButton(
            onPressed: () async {
              await registerRoom(room);
            },
            child: Text('Register'),
          )
              : Text('Not Available'),
        );
      }).toList();
    });
  }

  Future<void> registerRoom(String room) async {
    final hostelDoc = await FirebaseFirestore.instance.collection('hostels').doc(widget.hostelId).get();
    final roomData = hostelDoc.data()?['${widget.wing}'];
    final wingData = hostelDoc.data()?['wings'];
    final rooms = hostelDoc.data()?['rooms'];

    await FirebaseFirestore.instance.collection('hostels').doc(widget.hostelId).update({
      '${widget.wing}.$room': false,
      'wings.${widget.wing}': int.parse(wingData[widget.wing].toString()) - 1,
      'rooms': rooms - 1,
    });


    await FirebaseFirestore.instance.collection("users").doc(
        FirebaseAuth.instance.currentUser?.uid).update(
        {"hostel": widget.hostelId, "wing": widget.wing, "room": room});


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlocProvider(
        create: (context) => AllotmentBloc(),
        child: AllotmentDetails(hostelId: widget.hostelId, wing: widget.wing, room: room),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Wing Rooms'),
      ),
      body: roomWidgets.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: roomWidgets,
      ),
    );
  }
}
