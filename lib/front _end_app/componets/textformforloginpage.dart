import 'package:flutter/material.dart';

class Inputform extends StatefulWidget {
  const Inputform(
      {super.key,
      this.noteye,
      this.changingicon,
      required this.hintext,
      required this.obsure,
      required this.profile,
      required this.control,
      this.valid,
      this.eye});

  final String? hintext;
  final bool? obsure;
  final IconButton? eye;
  final IconButton? noteye;
  final Icon? profile;
  final TextEditingController control;
  final FormFieldValidator<String>? valid;
  final bool? changingicon;

  @override
  State<Inputform> createState() => _InputformState();
}

class _InputformState extends State<Inputform> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          TextFormField(
              controller: widget.control,
              obscureText: widget.obsure ?? false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(500)),
                  fillColor: Colors.black,
                  hintText: widget.hintext,

                  // icon: Icon(Icons.people),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  prefixIcon: widget.profile,
                  suffixIcon: widget.eye),
              validator: widget.valid),
        ],
      ),
    );
  }
}
