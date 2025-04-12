import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:theisi_app/front%20_end_app/componets/chart.dart';
import 'package:theisi_app/front%20_end_app/componets/rececentaddedproduct.dart';
import 'package:theisi_app/front%20_end_app/models/modeldata.dart';
import 'package:theisi_app/service/authservice.dart';
import 'package:theisi_app/service/database.dart';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  List<String> date = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  final currentdateandmonth = DateFormat('MMM dd, yyyy');
  String? newvalue;
  List<Modeldataforproducts> product = [];
  List<Modeldataforproducts> filterproducts = [];
  Databaseservices dbservice = Databaseservices();
  final Authservice _auth = Authservice();
  Map<String, dynamic> accountinfo = {};

  void getaccount() async {
    Map<String, dynamic> account = await _auth.getuserrole();

    setState(() {
      accountinfo = account;
    });
  }

  void fetchproducts() {
    dbservice.getProducts().listen((snapshot) {
      List<Modeldataforproducts> templist = [];

      for (var docs in snapshot.docs) {
        Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
        templist.add(Modeldataforproducts(
          name: data['name'] ?? '',
          id: docs.id,
          resupply: data['initalStock'] ?? 0,
          total: data['initalStock'] ?? 0,
          layer: data['layer'] ?? 0,
        ));
      }
      setState(() {
        product = templist;
        filterproducts = List.from(product);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getaccount();
    fetchproducts();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF2C2E31),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.09),
        child: AppBar(
          backgroundColor: Color(0xFF2C2E31),
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Vertical center
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${accountinfo['role']}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  '${accountinfo['Name']}',
                  style: TextStyle(fontSize: 17, color: Colors.white70),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are you sure you want to logout?'),
                      content: Text('Do you really want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await _auth.signout();
                            Navigator.pop(context);
                            print('logout $_auth');
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.person),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Container(
                    color: Color(0xFF2D3641),
                    height: screenHeight * 0.08,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Inventory Dashboard',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentdateandmonth.format(DateTime.now()),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Month',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              value: newvalue,
                              onChanged: (value) {
                                setState(() {
                                  newvalue = value;
                                  print(value);
                                });
                              },
                              dropdownStyleData: DropdownStyleData(
                                width: 100,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 30,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                              buttonStyleData: ButtonStyleData(
                                width: 100,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                                elevation: 0,
                              ),
                              items: date
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Monthly Sales',
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 250,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Chart(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inventory Transaction',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: screenHeight * 0.30,
                            child: ListView.builder(
                              itemCount: filterproducts.length,
                              itemBuilder: (context, index) {
                                return Recentproduct(
                                  name: filterproducts[index].name,
                                  role: 'Admin ${accountinfo['Name']}',
                                  date: 'now',
                                  quantity: filterproducts[index].total,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
