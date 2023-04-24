import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class companyForm extends StatefulWidget {
  companyForm();
  @override
  _companyFormState createState() => _companyFormState();
}

class _companyFormState extends State<companyForm> {
  TextEditingController departdate = TextEditingController();
  TextEditingController arrivaldate = TextEditingController();
  TextEditingController departtime = TextEditingController();
  TextEditingController arrivaltime = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.all(15.0),
          child: formUI(),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Company Form",
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
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            icon: const Icon(Icons.calendar_today),
            hintText: 'Enter the date',
            labelText: 'Date of Departure',
          ),
          keyboardType: TextInputType.datetime,
          controller: departdate,
          onTap: () async {
            var pickeddate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickeddate != null) {
              String formatteddate =
                  DateFormat('dd-MM-yyyy').format(pickeddate);

              setState(() {
                departdate.text = formatteddate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            icon: const Icon(Icons.calendar_today),
            hintText: 'Enter the date',
            labelText: 'Date of Arrival',
          ),
          keyboardType: TextInputType.datetime,
          controller: arrivaldate,
          onTap: () async {
            var pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(pickedDate);

              setState(() {
                arrivaldate.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            icon: const Icon(Icons.access_time),
            hintText: 'Enter the time of leaving',
            labelText: 'Departure Time',
          ),
          keyboardType: TextInputType.datetime,
          controller: departtime,
          onTap: () async {
            var pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );

            if (pickedTime != null) {
              setState(() {
                departtime.text = pickedTime.format(context);
              });
            } else {
              print("Time is not selected");
            }
          },
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            icon: const Icon(Icons.access_time),
            hintText: 'Enter a expected arrival time',
            labelText: 'In Time',
          ),
          keyboardType: TextInputType.datetime,
          controller: arrivaltime,
          onTap: () async {
            var pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );

            if (pickedTime != null) {
              setState(() {
                arrivaltime.text = pickedTime.format(context);
              });
            } else {
              print("Time is not selected");
            }
          },
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            icon: const Icon(Icons.add_location),
            hintText: 'Enter the address of visit',
            labelText: 'Address',
          ),
          keyboardType: TextInputType.text,
          controller: address,
        ),
        SizedBox(height: 20),
        TextField(
          maxLines: null,
          minLines: 6,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            filled: true,
            icon: const Icon(Icons.assistant),
            hintText: 'Enter the Reason of leave',
            labelText: 'Reason',
          ),
          controller: reason,
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
    CollectionReference leaves =
        FirebaseFirestore.instance.collection('companies');

    leaves.doc('OVV7qjqr1VzXTfkzplU0').update({
      'filledstudents': FieldValue.arrayUnion([2])
    });
    leaves.add({
      'departdate': departdate.text,
      'arrivaldate': arrivaldate.text,
      'departtime': departtime.text,
      'arrivaltime': arrivaltime.text,
      'address': address.text,
      'reason': reason.text
    });
    setState(() {
      departdate.clear();
      departtime.clear();
      arrivaldate.clear();
      arrivaltime.clear();
      address.clear();
      reason.clear();
    });
  }
}
