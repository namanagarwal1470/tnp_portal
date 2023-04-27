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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  arrowbackbutton(context),
                  Container(
                    height: (MediaQuery.of(context).size.height) * 0.1,
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: EdgeInsets.only(top: 50),
                    child: Text("All Companies",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  Createfine(context)
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
                            itemCount: companyname.length,
                            itemBuilder: (context, index) {
                              return Cont(
                                companyname[index],
                              );
                            })),
              ),
            ],
          ),
        ));
  }

  Widget Cont(String text1) {
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
              color:
                  //  text2 == "filled" ? Colors.green[300] :
                  Colors.grey[300],
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

      setState(() {
        companyname = e;

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
