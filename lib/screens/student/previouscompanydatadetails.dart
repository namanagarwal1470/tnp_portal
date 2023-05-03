import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class placementdata2 extends StatefulWidget {
  String companyname;
  placementdata2(this.companyname);

  @override
  State<placementdata2> createState() => _placementdata2State();
}

class _placementdata2State extends State<placementdata2> {
  var packageoffered;
  var noofoffers;
  var role;
  var cgpa;
  var month;

  bool isloading = true;

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
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
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
                            "Company Name",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                            "Package Offered",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            packageoffered,
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
                            "No of offers",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            noofoffers,
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                            "CGPA",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                            "Placement Drive Month",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            month,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ],
              )
            ]),
    );
  }

  fetch_all_data() async {
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('previouscompanies');

      List<DocumentSnapshot> finedocs =
          (await data.where('companyname', isEqualTo: widget.companyname).get())
              .docs;

      List<String> l = finedocs.map((e) => e.id as String).toList();
      print(l);

      List<String> e = finedocs.map((e) => e['role'] as String).toList();
      List<String> d =
          finedocs.map((e) => e['packageoffered'] as String).toList();
      List<String> r = finedocs.map((e) => e['noofoffers'] as String).toList();
      List<String> s = finedocs.map((e) => e['cgpa'] as String).toList();
      List<String> a = finedocs.map((e) => e['month'] as String).toList();

      setState(() {
        role = e[0];
        packageoffered = d[0];
        noofoffers = r[0];
        cgpa = s[0];
        month = a[0];

        isloading = false;
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
