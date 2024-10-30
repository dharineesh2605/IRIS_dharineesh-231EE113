import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/bloc/allotment/allotment_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllotmentBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Requests"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/adminhome');
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("requests").where("status", isEqualTo: "pending").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final request = snapshot.data!.docs[index];

                    return ListTile(
                      title: Text('Request from ${request['userId']}'),
                      subtitle: Text(
                          'Current Hostel: ${request['currentHostelId']}\n'
                              'Current Wing: ${request['currentWing']}\n'
                              'Current Room: ${request['currentRoom']}\n'
                              'Applied Hostel: ${request['newHostelId']}\n'
                              'Applied Wing: ${request['newWing']}\n'
                              'Applied Room: ${request['newRoom']}'
                      ),
                      trailing: Container(
                        width: 200,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final oldHostelDoc = await FirebaseFirestore.instance.collection('hostels').doc(request['currentHostelId']).get();
                                final oldWingData = oldHostelDoc.data()?['wings'];
                                final oldRooms = oldHostelDoc.data()?['rooms'];

                                await FirebaseFirestore.instance.collection('hostels').doc(request['currentHostelId']).update({
                                  '${request['currentWing']}.${request['currentRoom']}': true,
                                  'wings.${request['currentWing']}': oldWingData[request['currentWing']] + 1,
                                  'rooms': oldRooms + 1,
                                });

                                final newHostelDoc = await FirebaseFirestore.instance.collection('hostels').doc(request['newHostelId']).get();
                                final newWingData = newHostelDoc.data()?['wings'];
                                final newRooms = newHostelDoc.data()?['rooms'];

                                await FirebaseFirestore.instance.collection('hostels').doc(request['newHostelId']).update({
                                  '${request['newWing']}.${request['newRoom']}': false,
                                  'wings.${request['newWing']}': newWingData[request['newWing']] - 1,
                                  'rooms': newRooms - 1,
                                });

                                await FirebaseFirestore.instance.collection("requests").doc(request.id).update({
                                  "status": "accepted"
                                });


                                await FirebaseFirestore.instance.collection("users").doc(request['userId']).update({
                                  "hostel": request['newHostelId'],
                                  "wing": request['newWing'],
                                  "room": request['newRoom'],
                                });

                                setState(() {});

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Request accepted')),
                                );
                              },
                              child: Text('Accept'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance.collection("requests").doc(request.id).update({
                                  "status": "rejected"
                                });

                                setState(() {});

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Request rejected')),
                                );
                              },
                              child: Text('Reject'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text('No pending requests'));
            }
          },
        ),
      ),
    );
  }
}