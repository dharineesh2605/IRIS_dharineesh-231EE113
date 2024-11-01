import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iris_app/wingrooms.dart';
import 'bloc/allotment/allotment_bloc.dart';


class HostelWings extends StatefulWidget {
  final String? hostelId;

  HostelWings({required this.hostelId});

  @override
  _HostelWingsState createState() => _HostelWingsState();
}

class _HostelWingsState extends State<HostelWings> {
  List<Widget> wingWidgets = [];

  @override
  void initState() {
    fetchWingData();
  }

  Future<void> fetchWingData() async {
    final hostelDoc = await FirebaseFirestore.instance.collection('hostels').doc(widget.hostelId).get();
    final wingData = hostelDoc.data()?['wings'];

    setState(() {
      wingWidgets = wingData.keys.map<Widget>((wing) {
        return ListTile(
          title: Text(wing),
          subtitle: Text('${wingData[wing]} rooms'),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WingRooms(wing: wing, hostelId: widget.hostelId),
                ));
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
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/userhome');
            },
          ),
        ],
      ),
      body: wingWidgets.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: wingWidgets,
      ),
    );
  }
}





