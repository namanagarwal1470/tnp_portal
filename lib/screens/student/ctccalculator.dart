import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ctc extends StatefulWidget {
  ctc();
  @override
  _ctcState createState() => _ctcState();
}

class _ctcState extends State<ctc> {
  TextEditingController rating1 = TextEditingController();
  TextEditingController rating2 = TextEditingController();
  TextEditingController rating3 = TextEditingController();
  TextEditingController cgpa = TextEditingController();
  TextEditingController question1 = TextEditingController();
  TextEditingController question2 = TextEditingController();
  TextEditingController intern = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.all(15.0),
          child: formUI(),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Ctc Calculator",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              )),
          height: 150,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
        ),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'cgpa',
            labelText: 'Cgpa',
          ),
          keyboardType: TextInputType.text,
          controller: cgpa,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Total no of internships',
            labelText: 'Total no of internships (0 if not done)',
          ),
          keyboardType: TextInputType.text,
          controller: intern,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Leetcode rating',
            labelText: 'Leetcode rating (0 if not available)',
          ),
          keyboardType: TextInputType.text,
          controller: rating1,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Codechef rating',
            labelText: 'Codechef rating (0 if not available)',
          ),
          keyboardType: TextInputType.text,
          controller: rating2,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'codeforces rating',
            labelText: 'Codeforces rating (0 if not available)',
          ),
          keyboardType: TextInputType.text,
          controller: rating3,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Leetcode no of questions',
            labelText: 'Leetcode no of questions (0 if not available)',
          ),
          keyboardType: TextInputType.text,
          controller: question1,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Gfg no of questions',
            labelText: 'Gfg no of questions (0 if not available)',
          ),
          keyboardType: TextInputType.text,
          controller: question2,
        ),
        SizedBox(height: 40),
        Submitbutton(context),
      ],
    );
  }

  Widget Submitbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (double.parse(cgpa.text) > 8) {
              if (int.parse(rating3.text) > 1800 ||
                  int.parse(rating2.text) > 2000 ||
                  int.parse(rating1.text) > 2000) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("CTC"),
                    content: const Text("30-40lpa"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("okay"),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("CTC"),
                    content: const Text("15-30lpa"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("okay"),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else if (double.parse(cgpa.text) > 7) {
              if (int.parse(rating3.text) > 1800 ||
                  int.parse(rating2.text) > 2000 ||
                  int.parse(rating1.text) > 2000) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("CTC"),
                    content: const Text("10-30lpa"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("okay"),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("CTC"),
                    content: const Text("10-12lpa"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("okay"),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              if (int.parse(rating3.text) > 1800 ||
                  int.parse(rating2.text) > 2000 ||
                  int.parse(rating1.text) > 2000) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("CTC"),
                    content: const Text("8-10"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("okay"),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("CTC"),
                    content: const Text("5-8"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(14),
                          child: const Text("okay"),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }

            setState(() {
              rating1.clear();
              rating2.clear();
              rating3.clear();
              question1.clear();
              question2.clear();
              cgpa.clear();
              intern.clear();
            });
          },
          child: Container(
            child: Center(
              child: Text(
                "Calculate",
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
    );
  }
}
