import 'package:flutter/material.dart';

class Cardclass extends StatefulWidget {
  const Cardclass(
      {super.key,
      required this.colors,
      required this.icons,
      required this.storagepage});
  final Color colors;
  final Image icons;
  final String storagepage;
  @override
  State<Cardclass> createState() => _CardclassState();
}

class _CardclassState extends State<Cardclass> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: widget.colors,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: widget.icons,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.storagepage,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
