import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/componets/qrredaer.dart';
import 'package:theisi_app/service/qrdatabase.dart';

class Registerfid extends StatefulWidget {
  const Registerfid({super.key});

  @override
  State<Registerfid> createState() => _RegisterfidState();
}

class _RegisterfidState extends State<Registerfid> {
  Qrdatabase rfid = Qrdatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register RFID'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrReader()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(10),
              ),
              child: Text('Register RFID'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(10),
              ),
              child: Text('Check available RFID'),
            ),
          ],
        ),
      ),
    );
  }
}
