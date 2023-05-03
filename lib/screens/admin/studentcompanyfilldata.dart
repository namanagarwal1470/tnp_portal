import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class companyapply3 extends StatefulWidget {
  String enrollno;
  String companyname;

  companyapply3(this.enrollno, this.companyname);

  @override
  State<companyapply3> createState() => _companyapply3State();
}

class _companyapply3State extends State<companyapply3> {
  var name = '';
  var email = '';
  var cgpa = '';
  var branch = '';
  var phoneno = '';
  var resume = '';

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
                      "Enroll no",
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
            Submitbutton(context),
          ],
        )
      ]),
    );
  }

  Widget Submitbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    );
  }

  fetch_all_data() async {
    try {
      CollectionReference data = await FirebaseFirestore.instance
          .collection('studentscompaniesapplied');

      List<DocumentSnapshot> finedocs = (await data
              .where("enrollno", isEqualTo: widget.enrollno)
              .where("companyname", isEqualTo: widget.companyname)
              .get())
          .docs;

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
