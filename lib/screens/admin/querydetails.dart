import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class studentcomplaint extends StatefulWidget {
  String enrollno;
  String date;
  String type;
  String complaint;
  String status;
  String docid;

  studentcomplaint(this.enrollno, this.complaint, this.type, this.date,
      this.status, this.docid);

  @override
  State<studentcomplaint> createState() => _studentcomplaintState();
}

class _studentcomplaintState extends State<studentcomplaint> {
  bool isresolve = false;
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
                      "Enroll no",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.enrollno,
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
                      "Query Type",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.complaint,
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
                      "Reason",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.type,
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
                      "Date of Query",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            widget.status == "false" && !isresolve
                ? resolvebutton(context)
                : Text("")
          ],
        )
      ]),
    );
  }

  Widget resolvebutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            updatedata();
            final snackBar = SnackBar(
              content: const Text(
                'Query resolved!',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: (Colors.deepPurple),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 2000),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {
              isresolve = true;
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                "Is resolved",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple),
            width: MediaQuery.of(context).size.width * 0.3,
            height: 45,
          ),
        ),
      ],
    );
  }

  updatedata() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore
          .collection('contactus')
          .doc(widget.docid)
          .update({'status': "true"});
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
