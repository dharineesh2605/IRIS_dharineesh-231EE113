import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iris_app/adminhome.dart';
import 'package:iris_app/allotment.dart';
import 'package:iris_app/login.dart';
import 'package:iris_app/signup.dart';
import 'adminrequests.dart';
import 'changehostel.dart';
import 'hostelwings.dart';
import 'userhome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // darkTheme: ThemeData.dark(), --> Dark theme

      title: 'Iris App',
      home: Login(),
      routes: {
        "/login": (context) => Login(),
        "/userhome": (context) => UserHome(),
        "/adminhome": (context) => Adminhome(),
        "/signup": (context) => Signup(),
        "/allotment": (context) => Allotment(),
        "/changehostel": (context) => ChangeHostel(),
        "/requests": (context) => Requests(),
        '/hostelwings': (context) => HostelWings(hostelId: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
