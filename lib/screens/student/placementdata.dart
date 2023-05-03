import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class placementdata extends StatefulWidget {
  placementdata();

  @override
  State<placementdata> createState() => _placementdataState();
}

class _placementdataState extends State<placementdata> {
  var average;
  var eligiblestudents;
  var highestpackage;
  var median;
  var noofstudentsplaced;
  var percentoftotaloffers;
  var percentstudentsplaced;
  var totaloffers;
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
                            "Year",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "2021-2022",
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
                            "Percent Students Placed",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            percentstudentsplaced[0] + '%',
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
                            "No Of Eligible Students",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            eligiblestudents[0],
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
                            "Highest Package",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            highestpackage[0],
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
                            "Average Package",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            average[0],
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
                            "Total Offers",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            totaloffers[0],
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
                            "No Of Students Placed",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            noofstudentsplaced[0],
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
                            "Percent Of Total Offers",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            percentoftotaloffers[0] + '%',
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
                            "Median Package",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            median[0],
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
          await FirebaseFirestore.instance.collection('placement');

      List<DocumentSnapshot> finedocs = (await data.get()).docs;

      List<String> l = finedocs.map((e) => e.id as String).toList();
      print(l);

      List<String> e = finedocs.map((e) => e['average'] as String).toList();
      List<String> d =
          finedocs.map((e) => e['eligiblestudents'] as String).toList();
      List<String> r =
          finedocs.map((e) => e['highestpackage'] as String).toList();
      List<String> s = finedocs.map((e) => e['median'] as String).toList();
      List<String> a =
          finedocs.map((e) => e['noofstudentsplaced'] as String).toList();
      List<String> t =
          finedocs.map((e) => e['percentoftotaloffers'] as String).toList();
      List<String> b =
          finedocs.map((e) => e['percentsudentsplaced'] as String).toList();
      List<String> c = finedocs.map((e) => e['totaloffers'] as String).toList();
      setState(() {
        average = e;
        eligiblestudents = d;
        highestpackage = r;
        median = s;
        noofstudentsplaced = a;
        percentoftotaloffers = t;
        percentstudentsplaced = b;
        totaloffers = c;
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
