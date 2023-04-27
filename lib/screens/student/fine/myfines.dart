import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_portal/screens/student/fine/myfinedetails.dart';

import 'package:tnp_portal/screens/admin/finemanagement/adminfinedetails.dart';
import 'package:tnp_portal/screens/admin/finemanagement/createfine.dart';

class myfine extends StatefulWidget {
  String enrollno;
  myfine(this.enrollno);

  @override
  _myfineState createState() => _myfineState();
}

class _myfineState extends State<myfine> {
  List reason = [];
  List date = [];
  List status = [];
  List amount = [];
  List type = [];
  List docid = [];

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetch_all_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                setState(() {
                  fetch_all_data();
                });
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  arrowbackbutton(context),
                  Container(
                    height: (MediaQuery.of(context).size.height) * 0.1,
                    margin: EdgeInsets.only(top: 50),
                    child: Text("My Fines",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: isloading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: reason.length,
                            itemBuilder: (context, index) {
                              return Cont(
                                  date[index],
                                  reason[index],
                                  status[index],
                                  amount[index],
                                  type[index],
                                  widget.enrollno,
                                  docid[index]);
                            })),
              ),
            ],
          ),
        ));
  }

  Widget Cont(String text2, String text3, String text4, String text5,
      String text6, String text1, String text7) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => myfinedetails(
                    text2, text3, text4, text5, text6, text1, text7)));
      },
      child: Container(
          height: 80,
          margin: EdgeInsets.only(left: 15, right: 15, top: 12),
          decoration: BoxDecoration(
              color: text4 == "paid" ? Colors.green[300] : Colors.red[300],
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    text3,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Amount: " + text5,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          )),
    );
  }

  fetch_all_data() async {
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('fines');
      List<DocumentSnapshot> finedocs =
          (await data.where('enrollno', isEqualTo: widget.enrollno).get()).docs;
      List<String> l = finedocs.map((e) => e.id as String).toList();

      List<String> d = finedocs.map((e) => e['date'] as String).toList();
      List<String> r = finedocs.map((e) => e['reason'] as String).toList();
      List<String> s = finedocs.map((e) => e['status'] as String).toList();
      List<String> a = finedocs.map((e) => e['amount'] as String).toList();
      List<String> t = finedocs.map((e) => e['type'] as String).toList();
      setState(() {
        amount = a;
        reason = r;
        date = d;
        status = s;
        type = t;
        docid = l;
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Widget arrowbackbutton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.deepPurple,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
