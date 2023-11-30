import 'package:admin_web_portal/Authentication/login.screen.dart';
import 'package:admin_web_portal/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart';
import 'package:admin_web_portal/screens/search_data.dart';
import 'package:admin_web_portal/screens/insert_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:admin_web_portal/screens/widget_tree.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAWLytsTZl-a1gTf7TzBdrJVmOTWF-KN8s",
        authDomain: "conveyor-system.firebaseapp.com",
        databaseURL: "https://conveyor-system-default-rtdb.firebaseio.com",
        projectId: "conveyor-system",
        storageBucket: "conveyor-system.appspot.com",
        messagingSenderId: "637077203923",
        appId: "1:637077203923:web:3895dff77b9267b1961d26",
        measurementId: "G-B5Y6WM0R1B"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Web Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ?  const LoginScreen() : const HomeScreen(),
    );
  }
}



