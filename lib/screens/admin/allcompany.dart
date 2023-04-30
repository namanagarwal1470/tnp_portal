import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_portal/screens/admin/companyprofile.dart';
import 'addcompanyform.dart';
import 'companyextradetail.dart';

class companymanagementpage extends StatefulWidget {
  companymanagementpage({Key? key}) : super(key: key);

  @override
  _companymanagementpageState createState() => _companymanagementpageState();
}

class _companymanagementpageState extends State<companymanagementpage> {
  List companyname = [];
  List status = [];
  List companyname2 = [];
  TextEditingController editingController = TextEditingController();
  List status2 = [];
  int inprocesscount = 0;
  int completedcount = 0;

  bool isloading = true;

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

      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query)) {
          dummyListData.add(item);
          dummystatusdata.add(status2[companyname2.indexOf(item)]);
        }
      });
      setState(() {
        companyname.clear();
        status.clear();

        companyname.addAll(dummyListData);
        status.addAll(dummystatusdata);
      });
      return;
    } else {
      setState(() {
        companyname.clear();
        status.clear();

        companyname = List.from(companyname2);
        status = List.from(status2);
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
                      "inprocess: " + inprocesscount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: Text("completed: " + completedcount.toString(),
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
                              return Cont(
                                companyname[index],
                                status[index],
                              );
                            })),
              ),
            ],
          ),
        ));
  }

  Widget Cont(String text1, String text2) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => companymanagementpage2(text1)));
      },
      child: Container(
          height: 60,
          margin: EdgeInsets.only(left: 15, right: 15, top: 12),
          decoration: BoxDecoration(
              color: text2 == "inprocess" ? Colors.yellow[300] : Colors.green,
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
      List<DocumentSnapshot> finedocs = (await data.get()).docs;
      List<String> l = finedocs.map((e) => e.id as String).toList();
      print(l);

      List<String> e = finedocs.map((e) => e['companyname'] as String).toList();
      List<String> s = finedocs.map((e) => e['status'] as String).toList();
      int incount = 0;
      int cocount = 0;

      for (var i in s) {
        if (i == "inprocess") {
          incount += 1;
        } else {
          cocount += 1;
        }
      }

      setState(() {
        companyname = e;
        companyname2 = List.from(companyname);
        status = s;
        status2 = List.from(status);
        inprocesscount = incount;
        completedcount = cocount;
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

  Widget Createfine(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.only(top: 20),
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(Icons.add),
          color: Colors.deepPurple,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => companyForm()));
          },
        ),
      ),
    );
  }
}
