import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class wardenprofile extends StatefulWidget {
  String enrollno;
  wardenprofile(this.enrollno);

  @override
  State<wardenprofile> createState() => _wardenprofileState();
}

class _wardenprofileState extends State<wardenprofile> {
  String name = '';
  String email = '';
  String mobileno = '';
 

  @override
  void initState() {
    super.initState();
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
                  h_factor * 23, w_factor * 312, h_factor * 16, "Id:"),
              textfield(h_factor * 50, w_factor * 312, true, widget.enrollno),
             
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Email :"),
              textfield(h_factor * 50, w_factor * 312, true, email),
              textcontainer(
                  h_factor * 23, w_factor * 312, h_factor * 16, "Mobileno:"),
              textfield(h_factor * 50, w_factor * 312, true, mobileno),
            ],
          )
        ]),
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

      List<String> em = leavesdocs.map((e) => e['email'] as String).toList();
      
      List<String> nm = leavesdocs.map((e) => e['name'] as String).toList();
      List<String> pno = leavesdocs.map((e) => e['phoneno'] as String).toList();

      setState(() {
        name = nm[0];

        email = em[0];
        mobileno = pno[0];

      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}