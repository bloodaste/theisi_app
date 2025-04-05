import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:theisi_app/front%20_end_app/componets/chart.dart';
import 'package:theisi_app/service/authservice.dart';

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

  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2E31),
      appBar: AppBar(
        title: Text(
          'Hello admin',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Are you suer want to logout'),
                          content: Text('Are you user wanna logut'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel')),
                            TextButton(
                                onPressed: () async {
                                  await _auth.signout();
                                  Navigator.pop(context);
                                  print('logout $_auth');
                                },
                                child: Text('logout'))
                          ],
                        ));
              },
              icon: Icon(
                Icons.person,
              ))
        ],
        elevation: 0,
        backgroundColor: Color(0xFF2C2E31),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Container(
                    color: Color(0xFF2D3641),
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Welcome to Homepage',
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'How may help You?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
