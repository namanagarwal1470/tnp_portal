import "package:flutter/material.dart";
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tnp_portal/screens/login.dart';

class splash extends StatefulWidget {
  splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  String enroll = '';
  String type = '';
  String name = '';
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 2);
    return Timer(duration, isuserroute);
  }

  isuserroute() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      enroll = await (prefs.getString('enroll') ?? '');
      type = await (prefs.getString('type') ?? '');
      name = await (prefs.getString('name') ?? '');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => loginpage()));

      print(enroll);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height) * 0.3,
                  width: (MediaQuery.of(context).size.width) * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(400))),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    height: (MediaQuery.of(context).size.height) * 0.4,
                    width: (MediaQuery.of(context).size.width),
                    child: Center(
                      child: Text(
                        "T&P Portal",
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 50),
                      ),
                    ),
                    color: Colors.white)
              ],
            ),
            Row(
              children: [
                SizedBox(width: (MediaQuery.of(context).size.width) * 0.5),
                Container(
                  height: (MediaQuery.of(context).size.height) * 0.3,
                  width: (MediaQuery.of(context).size.width) * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(400))),
                )
              ],
            )
          ],
        ));
  }
}
