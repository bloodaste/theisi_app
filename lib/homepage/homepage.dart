import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/pages/inventorystatus.dart';
import 'package:theisi_app/front%20_end_app/pages/inventory.dart';
import 'package:theisi_app/front%20_end_app/pages/registerfid.dart';
import 'package:theisi_app/front%20_end_app/pages/restocksheet.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [
      Frontpage(),
      Analyticspage(),
      Newrfid(),
      Registerfid(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        backgroundColor: Colors.white,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits_rounded),
            label: 'Product Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Restock sheet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}
