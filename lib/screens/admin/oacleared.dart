import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_portal/screens/admin/studentdetails.dart';

class studentpage4 extends StatefulWidget {
  String companyname;
  studentpage4(this.companyname);

  @override
  _studentpage4State createState() => _studentpage4State();
}

class _studentpage4State extends State<studentpage4> {
  List enrollno = [];
  List enrollno2 = [];
  List status = [];
  List status2 = [];

  bool isloading = true;
  int totalcount = 0;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetch_all_data();
  }

  void filterSearchResults(String query) {
    var dummySearchList = [];
    dummySearchList.addAll(enrollno2);
    if (query.toLowerCase().isNotEmpty) {
      List<String> dummyenrolldata = [];
      List<bool> dummystatusdata = [];

      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query)) {
          dummyenrolldata.add(item);
          dummystatusdata.add(status2[enrollno2.indexOf(item)]);
        }
      });
      setState(() {
        enrollno.clear();
        status.clear();
        status.addAll(dummystatusdata);

        enrollno.addAll(dummyenrolldata);
      });
      return;
    } else {
      setState(() {
        enrollno.clear();
        status.clear();
        enrollno = List.from(enrollno2);
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
                    child: Text("OA cleared Students",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
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
                      "Total Students: " + totalcount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: Text("", style: TextStyle(color: Colors.white)),
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
                        : enrollno.length != 0
                            ? ListView.builder(
                                itemCount: enrollno.length,
                                itemBuilder: (context, index) {
                                  return Cont(
                                      enrollno[index], status[index], index);
                                })
                            : Center(child: Text("no students to show"))),
              ),
            ],
          ),
        ));
  }

  Widget Cont(String text1, var text2, var index) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             companyapply3(text1, widget.companyname)));
      },
      child: Container(
          height: 80,
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                      left: 15, right: MediaQuery.of(context).size.width * 0.3),
                  child: Text(
                    text1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.all(5),
                  icon: Icon(Icons.check_circle_outlined),
                  color: !text2 ? Colors.red : Colors.green,
                  iconSize: 40,
                  onPressed: () {
                    updatedata2(text1);
                    setState(() {
                      status[index] = true;
                    });
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => start2()));
                  },
                ),
              )
            ],
          )),
    );
  }

  fetch_all_data() async {
    print(widget.companyname);
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('companies');
      List<DocumentSnapshot> studentdocs =
          (await data.where("companyname", isEqualTo: widget.companyname).get())
              .docs;

      var p = [];
      var s = [];
      var l = [];
      var e = [];
      for (var i in studentdocs) {
        p.add(i["oaclearedstudents"]);
        e.add(i['interviewclearedstudents']);
      }
      for (var i in p[0]) {
        if (i.toString() != "19103045") {
          s.add(i.toString());
        }
      }
      for (var i in s) {
        for (var j in e[0]) {
          if (i == j) {
            l.add(true);
            break;
          }
        }
        l.add(false);
      }

      setState(() {
        enrollno = s;
        status = l;
        status2 = List.from(status);

        enrollno2 = List.from(enrollno);
        totalcount = enrollno.length;

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

  updatedata2(var text1) async {
    CollectionReference leaves =
        FirebaseFirestore.instance.collection('companies');
    CollectionReference leaves2 =
        FirebaseFirestore.instance.collection('users');
    List<DocumentSnapshot> studentdocs =
        (await leaves.where("companyname", isEqualTo: widget.companyname).get())
            .docs;
    List<DocumentSnapshot> student2docs =
        (await leaves2.where("enrollno", isEqualTo: text1).get()).docs;
    List<String> l = studentdocs.map((e) => e.id as String).toList();
    List<String> l2 = student2docs.map((e) => e.id as String).toList();
    print(l2[0]);

    leaves.doc(l[0]).update({
      'interviewclearedstudents': FieldValue.arrayUnion([text1]),
      'status': "completed"
    });
    leaves2
        .doc(l2[0])
        .update({"placedcompany": widget.companyname, "status": "placed"});
  }
}
