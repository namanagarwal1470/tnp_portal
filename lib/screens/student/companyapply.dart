import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_portal/screens/student/companyformdetails.dart';
import 'package:url_launcher/url_launcher.dart';

class companyapply extends StatefulWidget {
  String companyname;
  String enrollno;
  String status;
  String docid;

  companyapply(this.companyname, this.enrollno, this.status, this.docid);

  @override
  State<companyapply> createState() => _companyapplyState();
}

class _companyapplyState extends State<companyapply> {
  var branch = '';
  var cgpa = '';
  var role = '';
  var package = '';
  var reason = '';
  var jd = '';

  @override
  void initState() {
    super.initState();
    fetch_all_data();
  }

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
                      branch,
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
                      cgpa,
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
                      role,
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
                      package,
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
                      reason,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    launch(jd);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => pdfpage("resume", resume)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Center(
                      child: Text(
                        "Jd ",
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
            widget.status == "notfilled" ? paybutton(context) : Text("")
          ],
        )
      ]),
    );
  }

  Widget paybutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => companyapply2(widget.companyname,
                        widget.enrollno, widget.status, widget.docid)));
          },
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                "Apply",
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

  updatedata() async {
    CollectionReference leaves =
        FirebaseFirestore.instance.collection('companies');

    leaves.doc(widget.docid).update({
      'filledstudents': FieldValue.arrayUnion([widget.enrollno]),
    });
    setState(() {
      final snackBar = SnackBar(
        content: const Text('Applied Successfully!'),
        backgroundColor: (Colors.green),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 4000),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  fetch_all_data() async {
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('companies');

      List<DocumentSnapshot> finedocs =
          (await data.where("companyname", isEqualTo: widget.companyname).get())
              .docs;

      List<String> l = finedocs.map((e) => e.id as String).toList();
      print(l);

      List<String> e = finedocs.map((e) => e['companyname'] as String).toList();
      List<String> d = finedocs.map((e) => e['package'] as String).toList();
      List<String> r = finedocs.map((e) => e['role'] as String).toList();
      List<String> s = finedocs.map((e) => e['branch'] as String).toList();
      List<String> a = finedocs.map((e) => e['cgpacut'] as String).toList();
      List<String> t =
          finedocs.map((e) => e['additionalinformation'] as String).toList();
      List<String> j = finedocs.map((e) => e['jd'] as String).toList();

      setState(() {
        cgpa = a[0];
        role = r[0];
        package = d[0];
        branch = s[0];
        reason = t[0];
        jd = j[0];
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
