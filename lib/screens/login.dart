import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginpage extends StatefulWidget {
  loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController enrollno = TextEditingController();
  TextEditingController password = TextEditingController();

  List id = [];
  List idpassword = [];
  List usertype = [];
  List name = [];

  Map<String, String> k = {};

  @override
  void initState() {
    // TODO: implement initState
    fetch_all_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(top: 25),
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.4,
                child:
                    Image(image: AssetImage("assets/images/jaypeelogo.png"))),
            SizedBox(height: 20),
            Text(
              "T&P Portal",
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: TextField(
                      controller: enrollno,
                      style: TextStyle(fontSize: 20),
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[700]),
                          labelText: "User Id",
                          hintText: "User Id",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: password,
                      style: TextStyle(fontSize: 20),
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[700]),
                          labelText: "Password",
                          hintText: "Password",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      routenavigator();
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ]),
    );
  }

  fetch_all_data() async {
    Map<String, String> r = {};
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('users');
      List<DocumentSnapshot> studentinfodocs = (await data.get()).docs;
      List<String> enrollno =
          studentinfodocs.map((e) => e['enrollno'] as String).toList();
      List<String> password =
          studentinfodocs.map((e) => e['password'] as String).toList();
      List<String> type =
          studentinfodocs.map((e) => e['type'] as String).toList();
      List<String> names =
          studentinfodocs.map((e) => e['name'] as String).toList();

      for (int i = 0; i < enrollno.length; i++) {
        r[enrollno[i]] = password[i];
      }
      setState(() {
        id = enrollno;
        idpassword = password;
        usertype = type;
        k = r;

        name = names;
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  routenavigator() {
    for (int i = 0; i < id.length; i++) {
      if (enrollno.text == id[i]) {
        if (password.text == idpassword[i]) {
          if (usertype[i] == "admin") {
            add_user(enrollno.text, usertype[i], name[i]);

            print("login admin");
          } else {
            add_user(enrollno.text, usertype[i], name[i]);

            print("login student");
          }
        } else {
          setState(() {
            final snackBar = SnackBar(
              content: const Text('Wrong Password entered!'),
              backgroundColor: (Colors.red),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 4000),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            password.clear();
          });
        }
      }
    }
  }

  void add_user(String en, String typeof, String n) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('enroll', en);
      await prefs.setString('type', typeof);
      await prefs.setString('name', n);
    } catch (e) {
      print("Error while adding user data check preferences");
    }
  }
}
