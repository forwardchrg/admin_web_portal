import 'package:admin_web_portal/Authentication/login.screen.dart';
import 'package:admin_web_portal/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_web_portal/screens/search_data.dart';
import 'package:admin_web_portal/screens/insert_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}
class _InsertDataState extends State<InsertData> {

  final userCurDateController = TextEditingController();
  final userFromAdController = TextEditingController();
  final userFromNameController = TextEditingController();
  final userToAdController = TextEditingController();
  final userToNameController = TextEditingController();
  final userShipTypeController = TextEditingController();
  final userTrackingNumController = TextEditingController();
  final userWeightController = TextEditingController();

  late DatabaseReference DataRef;
  @override
  void initState(){
    super.initState();
    DataRef = FirebaseDatabase.instance.ref();
  }

  @override

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white70,
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
          "Insert Data",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.black,
          ),

        ),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Insert in Realtime database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userCurDateController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Datetime',
                    hintText: 'Insert Current Datetime'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userFromAdController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address From',
                    hintText: 'Insert Address from'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userFromNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name From',
                    hintText: 'Insert Name from'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userToAdController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address To',
                    hintText: 'Insert Address to'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userToNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name To',
                    hintText: 'Insert Name to'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userShipTypeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shipping type',
                    hintText: 'Insert Shipping Type'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userTrackingNumController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tracking Number',
                    hintText: 'Insert Tracking Number'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: userWeightController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Weight',
                    hintText: 'Insert Weight'

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(onPressed: () {
                Map<String, String> users = {
                  'current_datetime': userCurDateController.text,
                  'sent_from_address': userFromAdController.text,
                  'sent_from_name': userFromNameController.text,
                  'sent_to_address': userToAdController.text,
                  'sent_to_name': userToNameController.text,
                  'shipping_type': userShipTypeController.text,
                  'tracking_number': userTrackingNumController.text,
                  'weight': userWeightController.text
                };
                DataRef.push().set(users);
              },
                child: const Text('Insert Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,

              ),
            ],
          ),
        ),
      ),
    );




  }
}