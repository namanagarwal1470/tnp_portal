import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_portal/screens/admin/companyprofile.dart';
import 'addcompanyform.dart';

class companymanagementpage2 extends StatefulWidget {
  String companyname;
  companymanagementpage2(this.companyname);

  @override
  _companymanagementpage2State createState() => _companymanagementpage2State();
}

class _companymanagementpage2State extends State<companymanagementpage2> {
  List companyname = [
    "Company Information",
    "filled students",
    "Initial Shortlisted Students",
    'OA cleared students',
    "Interview Cleared Students"
  ];
  var package = '';
  var role = '';
  var additional = '';
  var branch = '';
  var cgpacut = '';
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
                setState(() {});
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
                    child: Text(widget.companyname,
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  // Createfine(context)
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
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: companyname.length,
                            itemBuilder: (context, index) {
                              return Cont(companyname[index], package, role,
                                  additional, branch, cgpacut, index);
                            })),
              ),
            ],
          ),
        ));
  }

  Widget Cont(String text1, String text2, String text3, String text4,
      String text5, String text6, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => myleavedetails(
                      widget.companyname, text2, text3, text4, text5, text6)));
        }
      },
      child: Container(
          height: 80,
          margin: EdgeInsets.only(left: 15, right: 15, top: 12),
          decoration: BoxDecoration(
              color:
                  //  text2 == "filled" ? Colors.green[300] :
                  Colors.grey[300],
              borderRadius: BorderRadius.circular(20)),
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
      List<DocumentSnapshot> finedocs =
          (await data.where('companyname', isEqualTo: widget.companyname).get())
              .docs;
      List<String> l = finedocs.map((e) => e.id as String).toList();
      print(l);

      List<String> d = finedocs.map((e) => e['package'] as String).toList();
      List<String> r = finedocs.map((e) => e['role'] as String).toList();
      List<String> s = finedocs.map((e) => e['branch'] as String).toList();
      List<String> a = finedocs.map((e) => e['cgpacut'] as String).toList();
      List<String> t =
          finedocs.map((e) => e['additionalinformation'] as String).toList();
      setState(() {
        cgpacut = a[0];
        role = r[0];
        package = d[0];
        branch = s[0];
        additional = t[0];
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
