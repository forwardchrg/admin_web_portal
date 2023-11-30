import 'package:admin_web_portal/Authentication/login.screen.dart';
import 'package:admin_web_portal/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_web_portal/screens/search_data.dart';
import 'package:admin_web_portal/screens/insert_data.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:admin_web_portal/screens/update_data.dart';

import 'dart:async';
class SearchData extends StatefulWidget {
  const SearchData({Key? key}) : super(key: key);

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  Query dataRef = FirebaseDatabase.instance.ref();
  DatabaseReference reference = FirebaseDatabase.instance.ref();
  String tracking_number = "";

  Widget listItem({required Map user}) {
    return Container(

      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 260,
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,


        //set text from database

        children: [
          Text(
            user['current_datetime'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),

          //if add user throws null
          Text(
            user['sent_from_address'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user['sent_from_name'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user['tracking_number'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user['sent_to_address'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user['sent_to_name'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user['shipping_type'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user['weight'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateData(userKey: user['key'])));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () {
                  reference.child(user['key']).remove();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                  ],
                ),
              ),
            ],
          )

        ],


      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:  LinearGradient(
              colors:
              [
                Colors.blueAccent ,
                Colors.grey,
              ],
              begin: FractionalOffset(0,0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,

            ),
          ),
        ),
        title: const Text(
          "Search Data",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.white,
          ),

        ),
        centerTitle: true,
      ),




      //animated boxes for later

      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dataRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            Map user = snapshot.value as Map;
            user['key'] = snapshot.key;
            return listItem(user: user);
          },
        ),
      ),


    );
  }
}