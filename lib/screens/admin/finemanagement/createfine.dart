import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class createfine extends StatefulWidget {
  createfine();

  @override
  _createfineState createState() => _createfineState();
}

class _createfineState extends State<createfine> {
  String fine_type = 'absent';
  String finalDate = '';
  TextEditingController enrollno = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController amount = TextEditingController();
  List<DropdownMenuItem<String>> items = [
    new DropdownMenuItem(
      child: new Text('absent'),
      value: 'absent',
    ),
    new DropdownMenuItem(
      child: new Text('misbehave'),
      value: 'misbehave',
    ),
    new DropdownMenuItem(
      child: new Text('dressing'),
      value: 'dressing',
    ),
    new DropdownMenuItem(
      child: new Text('Others'),
      value: 'others',
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
                  "Create Fine",
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
            "Fine Type",
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
                    hint: new Text('Select type of fine.'),
                    value: fine_type,
                    onChanged: (val) {
                      setState(() {
                        fine_type = val.toString();
                      });
                    },
                  )),
                ))
          ],
        ),
        SizedBox(height: 30),
        Container(
          child: Text(
            "Enroll no",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Enroll no',
            labelText: 'Enroll no',
          ),
          keyboardType: TextInputType.datetime,
          controller: enrollno,
        ),
        SizedBox(height: 30),
        Container(
          child: Text(
            "Amount",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            hintText: 'Amount',
            labelText: 'Amount',
          ),
          keyboardType: TextInputType.datetime,
          controller: amount,
        ),
        SizedBox(height: 30),
        Container(
          child: Text(
            "Reason",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
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
              content: const Text(
                'Successfully Created!',
                style: TextStyle(color: Colors.white),
              ),
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
                "Create",
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
    CollectionReference fine = FirebaseFirestore.instance.collection('fines');
    fine.add({
      'enrollno': enrollno.text,
      'type': fine_type,
      'status': "notpaid",
      'amount': amount.text,
      'reason': message.text,
      'date': finalDate
    });
    setState(() {
      fine_type = 'absent';
      message.clear();
      amount.clear();
      enrollno.clear();
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
