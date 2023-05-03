import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_portal/screens/admin/addcompanyform.dart';
import 'companyform.dart';
import 'companyapply.dart';

class companypage extends StatefulWidget {
  String enrollno;
  companypage(this.enrollno);

  @override
  _companypageState createState() => _companypageState();
}

class _companypageState extends State<companypage> {
  bool isloading = true;
  List companyname = [];
  List companyname2 = [];
  List docid = [];
  List docid2 = [];
  List status = [];
  List status2 = [];
  var filledcount;
  var notfilledcount;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    fetch_all_data();
  }

  void filterSearchResults(String query) {
    var dummySearchList = [];
    dummySearchList.addAll(companyname2);
    if (query.toLowerCase().isNotEmpty) {
      List<String> dummyListData = [];
      List<String> dummystatusdata = [];
      List<String> dummydocdata = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query)) {
          dummyListData.add(item);
          dummystatusdata.add(status2[companyname2.indexOf(item)]);
          dummydocdata.add(docid2[companyname2.indexOf(item)]);
        }
      });
      setState(() {
        companyname.clear();
        status.clear();
        docid.clear();
        companyname.addAll(dummyListData);
        status.addAll(dummystatusdata);
        docid.addAll(dummydocdata);
      });
      return;
    } else {
      setState(() {
        companyname.clear();
        status.clear();
        docid.clear();
        companyname = List.from(companyname2);
        status = List.from(status2);
        docid = List.from(docid2);
      });
    }
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
                    margin: EdgeInsets.only(left: 10, top: 50),
                    child: Text("All Companies",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 20.0),
                child: TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      iconColor: Colors.white,
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0)))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      "Filled: " + filledcount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: Text("Not Filled: " + notfilledcount.toString(),
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                            itemCount: companyname.length,
                            itemBuilder: (context, index) {
                              return Cont(companyname[index], status[index],
                                  docid[index]);
                            })),
              ),
            ],
          ),
        ));
  }

  Widget Cont(String text1, String text2, String text3) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    companyapply(text1, widget.enrollno, text2, text3)));
      },
      child: Container(
          height: 60,
          margin: EdgeInsets.only(left: 15, right: 15, top: 12),
          decoration: BoxDecoration(
              color: text2 == "filled" ? Colors.green[300] : Colors.red[300],
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  text1,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }

  fetch_all_data() async {
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('companies');
      List<DocumentSnapshot> leavesdocs = (await data.get()).docs;
      List<String> r =
          leavesdocs.map((e) => e['companyname'] as String).toSet().toList();
      var s = leavesdocs.map((e) => e['filledstudents']).toList();
      List<String> t = [];
      List<String> l = leavesdocs.map((e) => e.id as String).toList();

      for (var i in s) {
        int count = 0;
        for (var m in i) {
          if (m == widget.enrollno) {
            count += 1;

            break;
          }
        }
        if (count == 0) {
          t.add("notfilled");
        } else {
          t.add("filled");
        }
      }

      int notfilled = 0;
      int filled = 0;
      for (var i in t) {
        if (i == 'notfilled') {
          notfilled++;
        } else {
          filled++;
        }
      }

      setState(() {
        companyname = r;
        companyname2 = List.from(companyname);
        status = t;

        status2 = List.from(status);
        docid = l;
        docid2 = List.from(docid);
        isloading = false;
        filledcount = filled;
        notfilledcount = notfilled;
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
