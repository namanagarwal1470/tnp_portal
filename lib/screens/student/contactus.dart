import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplainForm extends StatefulWidget {
  String enrollno;

  ComplainForm(this.enrollno);

  @override
  _ComplainFormState createState() => _ComplainFormState();
}

class _ComplainFormState extends State<ComplainForm> {
  String complain_type = 'cgpa';
  String roomno = '';
  String finalDate = '';
  TextEditingController message = TextEditingController();
  List<DropdownMenuItem<String>> items = [
    new DropdownMenuItem(
      child: new Text('Interview'),
      value: 'Interview',
    ),
    new DropdownMenuItem(
      child: new Text('Online test'),
      value: 'Online test',
    ),
    new DropdownMenuItem(
      child: new Text('Selection'),
      value: 'Selection',
    ),
    new DropdownMenuItem(
      child: new Text('cgpa'),
      value: 'cgpa',
    ),
    new DropdownMenuItem(
      child: new Text('Others'),
      value: 'Others',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(15.0),
          child: FormUI(),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Contact us",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              )),
          height: 150,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
        ),
        Container(
          child: Text(
            "Query Type",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[200], //background color of dropdown button
                  border: Border.all(
                      color: Colors.black), //border of dropdown button
                  borderRadius: BorderRadius.circular(
                      10), //border raiuds of dropdown button
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    items: items,
                    hint: new Text('Select type of query'),
                    value: complain_type,
                    onChanged: (val) {
                      setState(() {
                        complain_type = val.toString();
                      });
                    },
                  )),
                ))
          ],
        ),
        SizedBox(height: 30),
        new TextField(
          decoration: new InputDecoration(
            hintText: 'Reason',
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
          ),
          controller: message,
          maxLines: 5,
          maxLength: 256,
        ),
        SizedBox(height: 40),
        Submitbutton(context),
      ],
    );
  }

  Widget Submitbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            getCurrentDate();
            final snackBar = SnackBar(
              content: const Text('Successfully submitted!',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: (Colors.deepPurple),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 4000),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            senddata();
          },
          child: Container(
            child: Center(
              child: Text(
                "Submit",
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

  void senddata() async {
    CollectionReference complaint =
        FirebaseFirestore.instance.collection('contactus');
    complaint.add({
      'enrollno': widget.enrollno,
      'query': complain_type,
      'reason': message.text,
      'status': "false",
      'date': finalDate
    });
    setState(() {
      complain_type = 'cgpa';

      message.clear();
    });
  }

  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }
}
