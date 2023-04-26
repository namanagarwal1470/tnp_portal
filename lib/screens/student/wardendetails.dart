import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class wardenui extends StatefulWidget {
  wardenui();

  @override
  State<wardenui> createState() => _wardenuiState();
}

class _wardenuiState extends State<wardenui> {
  List contactno = [];
  List name = [];
  List email = [];
  bool isloading = true;

  @override
  void initState() {
    fetch_all_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: GestureDetector(
              onTap: () => {
                    Navigator.pop(context),
                  },
              child: Icon(Icons.arrow_back))),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
              DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Phoneno',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(name[0])),
                      DataCell(Text(contactno[0])),
                      DataCell(Text(email[0])),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(name[1])),
                      DataCell(Text(contactno[1])),
                      DataCell(Text(email[1])),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(name[2])),
                      DataCell(Text(contactno[2])),
                      DataCell(Text(email[2])),
                    ],
                  ),
                ],
              )
            ]),
    );
  }

  fetch_all_data() async {
    try {
      CollectionReference data =
          await FirebaseFirestore.instance.collection('tnpofficer');
      List<DocumentSnapshot> leavesdocs = (await data.get()).docs;
      List<String> r = leavesdocs.map((e) => e['name'] as String).toList();
      List<String> s = leavesdocs.map((e) => e['contactno'] as String).toList();
      List<String> t = leavesdocs.map((e) => e['email'] as String).toList();

      setState(() {
        name = r;
        email = t;
        contactno = s;
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
