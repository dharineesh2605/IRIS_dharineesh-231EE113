import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_events.dart';
import 'package:iris_app/bloc/allotment/allotment_state.dart';
import 'package:iris_app/signup.dart';

class ChangeHostel extends StatefulWidget {
  const ChangeHostel({super.key});

  @override
  State<ChangeHostel> createState() => _ChangeHostelState();
}

class _ChangeHostelState extends State<ChangeHostel> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllotmentBloc()..add(LoadHostels()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Change Hostel"),
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
                      onPressed: () async {
                        if (hostel['id'] != 'Not alloted' &&
                            hostel['rooms'] > 0) {
                          // Retrieve the current hostel ID from the Firestore database
                          final userSnapshot = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .get();
                          final currentHostelId =
                          userSnapshot.data()?['hostel'];

                          if (currentHostelId != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HostelWings1(
                                hostelId: hostel['id'],
                              )),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Current hostel not found')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Please select a valid hostel with available rooms')),
                          );
                        }
                      },
                      child: Text('Request Change'),
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

class HostelWings1 extends StatefulWidget {
  final String hostelId;

  HostelWings1({required this.hostelId});

  @override
  _HostelWings1State createState() => _HostelWings1State();
}

class _HostelWings1State extends State<HostelWings1> {
  List<Widget> _wingWidgets = [];

  @override
  void initState() {
    super.initState();
    _fetchWingData();
  }

  Future<void> _fetchWingData() async {
    final hostelDoc = await FirebaseFirestore.instance.collection('hostels').doc(widget.hostelId).get();
    final wingData = hostelDoc.data()?['wings'];

    setState(() {
      _wingWidgets = wingData.keys.map<Widget>((wing) {
        return ListTile(
          title: Text(wing),
          subtitle: Text('${wingData[wing]} rooms'),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WingRooms(wing: wing, hostelId: widget.hostelId)),
              );
            },
            child: Text('Register'),
          ),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Hostel Wings'),
      ),
      body: _wingWidgets.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: _wingWidgets,
      ),
    );
  }
}

class WingRooms extends StatefulWidget {
  final String wing;
  final String hostelId;

  WingRooms({required this.wing, required this.hostelId});

  @override
  _WingRoomsState createState() => _WingRoomsState();
}

class _WingRoomsState extends State<WingRooms> {
  List<Widget> roomWidgets = [];

  @override
  void initState() {
    super.initState();
    _fetchRoomData();
  }

  Future<void> _fetchRoomData() async {
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
              final userSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get();
              final currentHostelId = userSnapshot.data()?['hostel'];
              final currentWing = userSnapshot.data()?['wing'];
              final currentRoom = userSnapshot.data()?['room'];

              await FirebaseFirestore.instance.collection("requests").add({
                "userId": FirebaseAuth.instance.currentUser?.uid,
                "currentHostelId": currentHostelId,
                "newHostelId": widget.hostelId,
                "currentWing": currentWing,
                "newWing": widget.wing,
                "currentRoom": currentRoom,
                "newRoom": room,
                "status": "pending"
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Request sent to admin')),
              );
            },
            child: Text('Request Change'),
          )
              : Text('Not Available'),
        );
      }).toList();
    });
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