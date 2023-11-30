import 'dart:async';
import 'dart:js_interop';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_web_portal/main_screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:admin_web_portal/screens/auth.dart';
class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key? key}): super (key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  String adminEmail = "";
  String adminPassword = "";

  allowAdminToLogin() async
  {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking Credentials",
        style: TextStyle(
          fontSize: 36,
          color: Colors.black,
        ) ,
      ),
      backgroundColor: Colors.pinkAccent,
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
    ).then((fAuth)
        {
          currentAdmin = fAuth.user;
        }).catchError((onError)
    {
      //display error message
      final snackBar = SnackBar(
          content: Text(
              "Error Occured: " + onError.toString(),
            style: const TextStyle(
              fontSize: 36,
              color: Colors.black,
            ) ,
          ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if(currentAdmin != null)
      {
        //check if that admin record also exists in the
        //admin collection location in firebase database
        await FirebaseFirestore.instance
            .collection("admins")
            .doc(currentAdmin!.uid)
            .get().then((snap)
        {
        if(snap.exists)
          {
            Navigator.push(context,MaterialPageRoute(builder: (c)=> const HomeScreen()));
          }
        else
          {
            SnackBar snackBar = const SnackBar(
              content: Text(
                "No record found... you are not an admin",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                ) ,
              ),
              backgroundColor: Colors.pinkAccent,
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      }
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white70,
      body:Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //image
                  Image.asset(
                    "images/package-arrow.png"
                  ),

                  //email text field
                  TextField(
                    onChanged: (value)
                    {
                      adminEmail = value;
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyanAccent,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amberAccent,
                          width: 2,
                        )
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.black),
                      icon: Icon(
                        Icons.email,
                        color: Colors.cyanAccent
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  //password text field
                  TextField(
                    onChanged: (value)
                    {
                      adminPassword = value;
                    },
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyanAccent,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.amberAccent,
                            width: 2,
                          )
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black),
                      icon: Icon(
                          Icons.admin_panel_settings,
                          color: Colors.cyanAccent
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),

                  //button login
                  ElevatedButton(
                    onPressed: ()
                    {
                      allowAdminToLogin();


                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.cyanAccent),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.yellowAccent),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing:2,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
