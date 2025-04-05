import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key, this.input});

  final String? input;
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          '${widget.input}',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
