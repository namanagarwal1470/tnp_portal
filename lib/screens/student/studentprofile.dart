import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:url_launcher/url_launcher.dart';

class studentprofile extends StatefulWidget {
  String enrollno;
  studentprofile(this.enrollno);

  @override
  State<studentprofile> createState() => _studentprofileState();
}

class _studentprofileState extends State<studentprofile> {
  String name = '';
  String dob = '';
  String branch = '';
  String year = '';
  String email = '';
  String mobileno = '';
  String bloodgroup = '';
  String parentsname = '';
  String parentsmobile = '';
  String resume = '';
  // String localguardianname = '';
  // String localguardianmobile = '';
  String address = '';
  String placedcompany = '';
  String status = '';
  TextEditingController resume2 = TextEditingController();

  bool isloading = true;
  bool show = false;

  @override
  void initState() {
    fetch_all_data();
  }

  @override
  Widget build(BuildContext context) {
    double w_factor = MediaQuery.of(context).size.width / 360;
    double h_factor = MediaQuery.of(context).size.height / 800;
    return Scaffold(
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
        child: ListView(children: [
          Column(
            children: [
              Container(
                child: Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "Profile",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    )),
                height: 150,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20, right: 15, left: 15),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(50))),
              ),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Name:"),
              textfield(h_factor * 50, w_factor * 312, true, name),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Enrollno:"),
              textfield(h_factor * 50, w_factor * 312, true, widget.enrollno),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "DOB:"),
              textfield(h_factor * 50, w_factor * 312, true, dob),
              textcontainer(h_factor * 23, w_factor * 312, h_factor * 16,
                  "Branch & Year :"),
              textfield(
                  h_factor * 50, w_factor * 312, true, branch + "-" + year),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Email :"),
              textfield(h_factor * 50, w_factor * 312, true, email),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Mobileno:"),
              textfield(h_factor * 50, w_factor * 312, true, mobileno),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Blood group:"),
              textfield(h_factor * 50, w_factor * 312, true, bloodgroup),
              // textcontainer(h_factor * 23, w_factor * 312, h_factor * 16,
              //     "Hostel name & Room no :"),
              // textfield(h_factor * 50, w_factor * 312, true,
              //     hostelname + "-" + roomno),
              // textcontainer(
              //     h_factor * 23, w_factor * 312, h_factor * 16, "Floor:"),
              // textfield(h_factor * 50, w_factor * 312, true, floor),
              textcontainer(h_factor * 23, w_factor * 312, h_factor * 16,
                  "Parents name & Mobileno:"),
              textfield(h_factor * 50, w_factor * 312, true,
                  parentsname + "-" + parentsmobile),
              // textcontainer(h_factor * 23, w_factor * 312, h_factor * 16,
              //     "Local Guardian name & Mobileno:"),
              // textfield(h_factor * 50, w_factor * 312, true,
              //     localguardianname + "-" + localguardianmobile),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Address:"),
              textfield(h_factor * 50, w_factor * 312, true, address),
              status == 'placed'
                  ? textcontainer(h_factor * 23, w_factor * 312, h_factor * 16,
                      "Placed Company:")
                  : Text(""),
              status == 'placed'
                  ? textfield(
                      h_factor * 50, w_factor * 312, true, placedcompany)
                  : Text(""),
              SizedBox(height: 20),
              !show ? Submitbutton(context) : textfieldbutton(context),
              show ? resumeupdate(context) : Text("")
            ],
          )
        ]),
      ),
    );
  }

  Widget Submitbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            launch(resume);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => pdfpage("resume", resume)));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Text(
                "Resume ",
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
        GestureDetector(
          onTap: () {
            setState(() {
              show = true;
            });
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => pdfpage("resume", resume)));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Text(
                "Edit Resume",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple),
            width: MediaQuery.of(context).size.width * 0.35,
            height: 40,
          ),
        ),
      ],
    );
  }

  Widget resumeupdate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            updatedata();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => pdfpage("resume", resume)));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Text(
                "Update",
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
    CollectionReference leaves = FirebaseFirestore.instance.collection('users');
    List<DocumentSnapshot> studentdocs =
        (await leaves.where("enrollno", isEqualTo: widget.enrollno).get()).docs;
    List<String> l = studentdocs.map((e) => e.id as String).toList();

    leaves.doc(l[0]).update({
      'resume': resume2.text,
    });
    setState(() {
      final snackBar = SnackBar(
        content: const Text('Updated Successfully!'),
        backgroundColor: (Colors.green),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 4000),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      show = false;
      initState();
    });
  }

  Widget textfieldbutton(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.only(right: 30, left: 30, bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          filled: true,
          hintText: 'Resume link',
          labelText: 'Resume link',
        ),
        keyboardType: TextInputType.text,
        controller: resume2,
      ),
    );
  }

  Widget textcontainer(h, w, margintop, content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: margintop),
          height: h,
          width: w,
          child: Text(
            content,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget textfield(h, w, isshow, content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: h,
            width: w,
            child: isshow
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(),
                          child: Text(
                            content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ))
                    ],
                  )
                : Text(""))
      ],
    );
  }

  fetch_all_data() async {
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('users');
      List<DocumentSnapshot> leavesdocs =
          (await data.where('enrollno', isEqualTo: widget.enrollno).get()).docs;
      List<String> ad = leavesdocs.map((e) => e['address'] as String).toList();

      List<String> bg =
          leavesdocs.map((e) => e['bloodgroup'] as String).toList();
      List<String> br = leavesdocs.map((e) => e['branch'] as String).toList();
      List<String> db = leavesdocs.map((e) => e['dob'] as String).toList();
      List<String> em = leavesdocs.map((e) => e['email'] as String).toList();
      // List<String> fl = leavesdocs.map((e) => e['floor'] as String).toList();
      // List<String> h = leavesdocs.map((e) => e['hostel'] as String).toList();
      List<String> nm = leavesdocs.map((e) => e['name'] as String).toList();
      // List<String> lgn =
      //     leavesdocs.map((e) => e['local guardian name'] as String).toList();
      // List<String> lgp =
      //     leavesdocs.map((e) => e['local guardian phoneno'] as String).toList();
      List<String> pn =
          leavesdocs.map((e) => e['parent name'] as String).toList();
      List<String> pp =
          leavesdocs.map((e) => e['parent phoneno'] as String).toList();
      List<String> pno = leavesdocs.map((e) => e['phoneno'] as String).toList();
      // List<String> rn = leavesdocs.map((e) => e['roomno'] as String).toList();
      List<String> y = leavesdocs.map((e) => e['year'] as String).toList();
      var re = leavesdocs.map((e) => e['resume'] as String).toList();
      List<String> pc =
          leavesdocs.map((e) => e['placedcompany'] as String).toList();
      List<String> s = leavesdocs.map((e) => e['status'] as String).toList();
      setState(() {
        name = nm[0];
        dob = db[0];
        branch = br[0];
        year = y[0];
        email = em[0];
        mobileno = pno[0];
        bloodgroup = bg[0];
        // hostelname = h[0];
        // roomno = rn[0];
        // floor = fl[0];
        parentsname = pn[0];
        parentsmobile = pp[0];
        placedcompany = pc[0];
        status = s[0];
        // localguardianname = lgn[0];
        // localguardianmobile = lgp[0];
        address = ad[0];
        resume = re[0];
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
