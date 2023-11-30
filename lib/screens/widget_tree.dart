import 'package:admin_web_portal/Authentication/login.screen.dart';
import 'package:admin_web_portal/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_web_portal/screens/activate_user.dart';
import 'dart:async';
import 'package:admin_web_portal/screens/auth.dart';
import 'package:admin_web_portal/screens/activate_user.dart';
import 'package:admin_web_portal/screens/widget_tree.dart';
class WidgetTree extends StatefulWidget{
  const WidgetTree({Key ? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();

}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const ActivateUser();
          }

        },
    );
  }
}