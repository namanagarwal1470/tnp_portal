import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class companyapply2 extends StatefulWidget {
  String companyname;
  String enrollno;
  String status;
  String docid;

  companyapply2(this.companyname, this.enrollno, this.status, this.docid);

  @override
  State<companyapply2> createState() => _companyapply2State();
}

class _companyapply2State extends State<companyapply2> {
  var name = '';
  var email = '';
  var cgpa = '';
  var branch = '';
  var phoneno = '';
  var resume = '';
  bool show = false;
  TextEditingController resume2 = TextEditingController();

  @override
  void initState() {
   
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
                      "Name",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      name,
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
                      "Enrollno",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.enrollno,
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
                      "Cgpa",
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
                      "Email",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      email,
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
                      "Branch",
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
                      "Phone no",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      phoneno,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            !show ? Submitbutton(context) : textfieldbutton(context),
            show ? resumeupdate(context) : Text(""),
            widget.status == "notfilled" ? paybutton(context) : Text("")
          ],
        )
      ]),
    );
  }

  Widget Submitbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            launchurl(resume);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => pdfpage("resume", resume)));
          },
          child: Container(
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
            child: Center(
              child: Text(
                "Resume Edit",
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

  launchurl(String url) async {
    print(url);
    if (await canLaunch(url)) {
      print(url);
      await launch(url);
    } else {
      throw "could not open resume";
    }
  }

  Widget resumeupdate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            updatedata2();
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

  updatedata2() async {
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

  Widget paybutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            updatedata();
            Navigator.pop((context));
          },
          child: Container(
            margin: EdgeInsets.only(top: 30),
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
          await FirebaseFirestore.instance.collection('users');

      List<DocumentSnapshot> finedocs =
          (await data.where("enrollno", isEqualTo: widget.enrollno).get()).docs;

      List<String> l = finedocs.map((e) => e.id as String).toList();
      print(l);

      List<String> e = finedocs.map((e) => e['name'] as String).toList();
      List<String> d = finedocs.map((e) => e['cgpa'] as String).toList();
      List<String> r = finedocs.map((e) => e['email'] as String).toList();
      List<String> s = finedocs.map((e) => e['phoneno'] as String).toList();
      List<String> a = finedocs.map((e) => e['branch'] as String).toList();
      List<String> k = finedocs.map((e) => e['resume'] as String).toList();

      setState(() {
        cgpa = d[0];
        name = e[0];
        email = r[0];
        branch = a[0];
        phoneno = s[0];
        resume = k[0];
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
