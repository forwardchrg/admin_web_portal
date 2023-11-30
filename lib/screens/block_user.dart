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

class BlockUser extends StatefulWidget {
  const BlockUser({Key? key}) : super(key: key);

  @override
  State<BlockUser> createState() => _BlockUserState();
}

class _BlockUserState extends State<BlockUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.cyan,
                Colors.orange,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,

            ),
          ),
        ),
        title: const Text(
          "Block User",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.white,
          ),

        ),
        centerTitle: true,
      ),
    );
  }
}