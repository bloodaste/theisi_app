import 'package:flutter/material.dart';

class Recentproduct extends StatefulWidget {
  const Recentproduct({
    super.key,
    required this.role,
    required this.date,
    required this.name,
    required this.quantity,
  });
  final String role;
  final String name;
  final String date;
  final int quantity;
  @override
  State<Recentproduct> createState() => _RecentproductState();
}

class _RecentproductState extends State<Recentproduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.role,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.date,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              Text(
                '+ ${widget.quantity.toString()}',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
