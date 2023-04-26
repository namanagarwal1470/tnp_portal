import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class myleavedetails extends StatefulWidget {
  String companyname;
   String package;
  String role;
  String reason;
  String branch;
  String cgpa;

  myleavedetails(
    this.companyname,
    this.package, this.role, this.reason,
        this.branch, this.cgpa
  );

  @override
  State<myleavedetails> createState() => _myleavedetailsState();
}

class _myleavedetailsState extends State<myleavedetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: GestureDetector(
              onTap: () => {
                    Navigator.pop(context),
                  },
              child: Icon(Icons.arrow_back))),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Company name",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.companyname,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Eligible Branches",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.branch,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cgpa cut",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.cgpa,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Role",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.role,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Package",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.package,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Information",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.reason,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          ],
        )
      ]),
    );
  }
}