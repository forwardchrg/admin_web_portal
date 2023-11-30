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
import 'package:admin_web_portal/screens/widget_tree.dart';
class ActivateUser extends StatefulWidget {
  const ActivateUser({Key? key}) : super(key: key);

  @override
  State<ActivateUser> createState() => _ActivateUserState();

}

class _ActivateUserState extends State<ActivateUser> {
  //text controllers

  String? errorMessage = '';
  bool isLogin = true; // for later once we have buyers

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Hmmmm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: createUserWithEmailAndPassword,
        child: Text('Register'), );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.amberAccent,
                Colors.grey,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,

            ),
          ),
        ),
        title: const Text(
          "Activate User",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.white,
          ),

        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _emailController),
            _entryField('password', _passwordController),
            _errorMessage(),
            _submitButton(),
          ],
        ),
      ),



    );
  }
}