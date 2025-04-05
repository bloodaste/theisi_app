import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';

class Dropwonbutton extends StatefulWidget {
  const Dropwonbutton({
    super.key,
    required this.data,
    required this.newvalue,
    required this.onchangeofdropdownvalue,
  });
  final List<String> data;
  final String newvalue;
  final Function onchangeofdropdownvalue;
  @override
  State<Dropwonbutton> createState() => _DropwonbuttonState();
}

class _DropwonbuttonState extends State<Dropwonbutton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          'Month',
          style: TextStyle(fontSize: 15),
        ),
        value: widget.newvalue,
        onChanged: widget.onchangeofdropdownvalue(),
        // dropdownStyleData: DropdownStyleData(
        //   width: 100,
        // ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // color: Colors.redAccent,
          ),
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
          ),
        ),
        buttonStyleData: ButtonStyleData(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          elevation: 0,
        ),
        items: widget.data
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
      ),
    );
  }
}
