import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({
    super.key,
    this.uploadimage,
    required this.currentstock,
    required this.layernumber,
    required this.name,
    required this.needstoberestock,
    required this.rfid,
    required this.seletedrfid,
  });

  final Function(String) seletedrfid;
  final TextEditingController name;
  final TextEditingController currentstock;
  final TextEditingController needstoberestock;
  final TextEditingController layernumber;
  final VoidCallback? uploadimage;
  final List<Map<String, dynamic>> rfid;

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  String? selectedRfid;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.name,
            decoration: InputDecoration(
              label: Text('Name of the product'),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: widget.layernumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Layer number')),
          ),
          SizedBox(height: 10),
          TextField(
            controller: widget.currentstock,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Initial Stock')),
          ),
          SizedBox(height: 10),
          TextField(
            controller: widget.needstoberestock,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Need to resupply')),
          ),
          SizedBox(height: 10),
          DropdownButton2(
            value: selectedRfid,
            isExpanded: true,
            hint: Text('Available RFID'),
            onChanged: (value) {
              setState(() {
                selectedRfid = value.toString();
              });

              widget.seletedrfid(selectedRfid!);
              print("Selected RFID: $selectedRfid");
            },
            items: widget.rfid.where((e) => e['islinked'] == false).map((e) {
              return DropdownMenuItem(
                value: e['qr'].toString(),
                child: Text(e['qr'].toString()),
              );
            }).toList(),
          ),
          TextButton(
            onPressed: widget.uploadimage,
            child: Text('Image Type'),
          ),
        ],
      ),
    );
  }
}
