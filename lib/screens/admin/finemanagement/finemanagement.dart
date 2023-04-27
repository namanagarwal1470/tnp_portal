import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_portal/screens/admin/finemanagement/adminfinedetails.dart';
import 'package:tnp_portal/screens/admin/finemanagement/createfine.dart';

class finemanagementpage extends StatefulWidget {
  finemanagementpage({Key? key}) : super(key: key);

  @override
  _finemanagementpageState createState() => _finemanagementpageState();
}

class _finemanagementpageState extends State<finemanagementpage> {
  List enrollno = [];

  List reason = [];
  List date = [];
  List status = [];
  List amount = [];
  List type = [];

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
                    child: Text("All Fines",
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
                            itemCount: enrollno.length,
                            itemBuilder: (context, index) {
                              return Cont(
                                  enrollno[index],
                                  date[index],
                                  reason[index],
                                  status[index],
                                  amount[index],
                                  type[index]);
                            })),
              ),
            ],
          ),
        ));
  }

  Widget Cont(String text1, String text2, String text3, String text4,
      String text5, String text6) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    wardenfine(text1, text2, text3, text4, text5, text6)));
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
                    text6,
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
                  "Enrollno: " + text1,
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
      List<DocumentSnapshot> finedocs = (await data.get()).docs;
      List<String> l = finedocs.map((e) => e.id as String).toList();

      List<String> e = finedocs.map((e) => e['enrollno'] as String).toList();
      List<String> d = finedocs.map((e) => e['date'] as String).toList();
      List<String> r = finedocs.map((e) => e['reason'] as String).toList();
      List<String> s = finedocs.map((e) => e['status'] as String).toList();
      List<String> a = finedocs.map((e) => e['amount'] as String).toList();
      List<String> t = finedocs.map((e) => e['type'] as String).toList();
      setState(() {
        enrollno = e;

        amount = a;
        reason = r;
        date = d;
        status = s;
        type = t;

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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => createfine()));
          },
        ),
      ),
    );
  }
}