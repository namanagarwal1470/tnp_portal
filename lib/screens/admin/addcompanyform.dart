import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class companyForm extends StatefulWidget {
  companyForm();
  @override
  _companyFormState createState() => _companyFormState();
}

class _companyFormState extends State<companyForm> {
  TextEditingController companyname = TextEditingController();
  TextEditingController package = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController cgpa = TextEditingController();
  TextEditingController branches = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController jd = TextEditingController();

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
                  "Company Form",
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
            hintText: 'Company Name',
            labelText: 'Company Name',
          ),
          keyboardType: TextInputType.text,
          controller: companyname,
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
            hintText: 'Eligible Branches',
            labelText: 'Eligible Branches',
          ),
          keyboardType: TextInputType.text,
          controller: branches,
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
            hintText: 'Cgpa cut',
            labelText: 'Cgpa cut',
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
            hintText: 'Role',
            labelText: 'Role',
          ),
          keyboardType: TextInputType.text,
          controller: role,
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
            hintText: 'Package',
            labelText: 'Package',
          ),
          keyboardType: TextInputType.text,
          controller: package,
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
            hintText: 'JD link',
            labelText: 'JD link',
          ),
          keyboardType: TextInputType.text,
          controller: jd,
        ),
        SizedBox(height: 20),
        TextField(
          maxLines: null,
          minLines: 6,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Additional Information',
            labelText: 'Additional Information',
          ),
          controller: reason,
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
            final snackBar = SnackBar(
              content: const Text('Successfully submitted!',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: (Colors.deepPurple),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 4000),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            senddata();
          },
          child: Container(
            child: Center(
              child: Text(
                "Add",
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

  void senddata() async {
    CollectionReference leaves =
        FirebaseFirestore.instance.collection('companies');

    leaves.add({
      'companyname': companyname.text,
      'branch': branches.text,
      'package': package.text,
      'role': role.text,
      'cgpacut': cgpa.text,
      'filledstudents': FieldValue.arrayUnion(["19103045"]),
      'initialshortlistedstudents': FieldValue.arrayUnion(["19103045"]),
      'oaclearedstudents': FieldValue.arrayUnion(["19103045"]),
      'interviewclearedstudents': FieldValue.arrayUnion(["19103045"]),
      'additionalinformation': reason.text,
      'jd': jd.text,
      'status':'inprocess'
    });
    setState(() {
      branches.clear();
      cgpa.clear();
      role.clear();
      package.clear();
      companyname.clear();
      reason.clear();
    });
  }
}
