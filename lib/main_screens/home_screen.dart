import 'dart:async';
import 'dart:js_interop';
import 'package:admin_web_portal/Authentication/login.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_web_portal/screens/search_data.dart';
import 'package:admin_web_portal/screens/insert_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:admin_web_portal/screens/activate_user.dart';
import 'package:admin_web_portal/screens/block_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:admin_web_portal/screens/widget_tree.dart';
class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{

  String timeText = "";
  String dateText = "";


  String formatCurrentLiveTime(DateTime time)
  {

    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime()
  {
    final DateTime timenow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timenow);
    final String liveDate = formatCurrentDate(timenow);

    if(this.mounted)
      {
        setState(() {
          timeText = liveTime;
          dateText = liveDate;

        });
      }
  }


  @override
  void initState()
  {
    super.initState();

    //time
    timeText = formatCurrentLiveTime(DateTime.now());
    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTime();
    });


  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:  LinearGradient(
              colors:
              [
                Colors.blueAccent ,
                Colors.redAccent,
              ],
              begin: FractionalOffset(0,0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,

            ),
          ),
        ),
        title: const Text(
          "Admin Web Portal",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.white,
          ),

        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                timeText + "\n" + dateText,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            //user activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //activate
                ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.white,),
                  label: Text(
                    "Activate User".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(40),
                    primary: Colors.cyan,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ActivateUser()),
                    );
                  },
                ),

                const SizedBox(width: 20,),


                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "Block User".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(40),
                    primary: Colors.greenAccent,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BlockUser()),
                    );
                  },
                ),

              ],
            ),

            //sellers activate and block accounts button UI
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //activate
                ElevatedButton.icon(
                  icon: Icon(Icons.person_add, color: Colors.white,),
                  label: Text(
                    "Activate Buyer".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(40),
                    primary: Colors.orangeAccent,
                  ),
                  onPressed: ()
                  {

                  },
                ),

                const SizedBox(width: 20,),


                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "Block Buyer".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    primary: Colors.redAccent,
                  ),
                  onPressed: ()
                  {

                  },
                ),

              ],
            ),

          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white,),
              label: Text(
                "Logout".toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(40),
                primary: Colors.purple,
              ),

              onPressed: ()
              {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginScreen()));
              },
            ),

            const SizedBox(width: 20,),

            //logout button
            ElevatedButton.icon(
              icon: const Icon(Icons.search, color: Colors.white,),
              label: Text(
                "Search Data".toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(40),
                primary: Colors.blueAccent,
              ),
              onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchData()),
                );
              },
            ),
            const SizedBox(width: 20,),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_box, color: Colors.white,),
              label: Text(
                "Insert Data".toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(40),
                primary: Colors.redAccent,
              ),
              onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InsertData()),
                );
              },
            ),
            ],
          ),

          ],
        ),
      ),
    );


  }
}




