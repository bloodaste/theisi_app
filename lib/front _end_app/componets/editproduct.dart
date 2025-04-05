import 'package:flutter/material.dart';

class ProductEdit extends StatefulWidget {
  final String productname;
  final int layernumber;
  final int currentstock;
  final int needtoberestock;
  const ProductEdit(
      {super.key,
      required this.currentstock,
      required this.layernumber,
      required this.needtoberestock,
      required this.productname});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('product info'),
      ),
      body: Column(
        children: [
          Text('${widget.currentstock}'),
          Text('${widget.layernumber}'),
          Text(widget.productname),
          Text('${widget.needtoberestock}')
        ],
      ),
    ));
  }
}
