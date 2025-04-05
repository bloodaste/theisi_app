import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/models/modeldata.dart';
import 'package:theisi_app/service/database.dart';

class Newrfid extends StatefulWidget {
  const Newrfid({super.key});

  @override
  State<Newrfid> createState() => _NewrfidState();
}

class _NewrfidState extends State<Newrfid> {
  List<Modeldataforproducts> invetorysheet = [];
  Databaseservices infosheet = Databaseservices();

  void restockSheet() {
    infosheet.getProducts().listen((event) {
      List<Modeldataforproducts> tempList = []; //

      for (var doc in event.docs) {
        var data = doc.data();
        if (data == null || data is! Map<String, dynamic>) {
          continue; // Ensure valid data
        }

        tempList.add(Modeldataforproducts(
          name: data['name'] ?? '',
          id: doc.id,
          resupply: data['restockvalue'] ?? 0,
          total: data['initalStock'] ?? 0, // Fixed typo
          layer: data['layernumber'] ?? 0,
        ));
      }

      setState(() {
        invetorysheet = tempList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    restockSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restock Sheet'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                'Inventory stock level',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 35,
                    columns: [
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Current Stock',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Restock Value',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: invetorysheet
                        .map((e) => DataRow(cells: [
                              DataCell(Center(child: Text(e.name))),
                              DataCell(Center(child: Text(e.total.toString()))),
                              DataCell(
                                  Center(child: Text(e.resupply.toString()))),
                            ]))
                        .toList(), // Convert map to list
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 15),
                  ),
                  child: Text('Submit Stock report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
