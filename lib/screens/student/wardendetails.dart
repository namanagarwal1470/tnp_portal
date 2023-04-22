import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class wardenui extends StatefulWidget {
  wardenui();

  @override
  State<wardenui> createState() => _wardenuiState();
}

class _wardenuiState extends State<wardenui> {
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
      body: ListView(children: [
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
                DataCell(Text('Vinod Kumar')),
                DataCell(Text('9363638383')),
                DataCell(Text('vinod@gmail.com')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Anita Marwaha')),
                DataCell(Text('9828282282')),
                DataCell(Text('anita@gmail.com')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Anurag Srivastava')),
                DataCell(Text('9763737373')),
                DataCell(Text('anurag@gmail.com')),
              ],
            ),
          ],
        )
      ]),
    );
  }
}