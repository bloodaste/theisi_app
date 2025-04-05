// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:theisi_app/front%20_end_app/componets/button.dart';
import 'package:theisi_app/front%20_end_app/componets/textformforloginpage.dart';
import 'package:theisi_app/service/authservice.dart';

class Forgotpasswordpage extends StatefulWidget {
  const Forgotpasswordpage({super.key});

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  TextEditingController resetemail = TextEditingController();
  final Authservice _authservice = Authservice();

  @override
  void dispose() {
    resetemail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Please enter your registered email address below. We will send you a password reset link to help you securely regain access to your account. Make sure to check your inbox, including the spam or junk folder, for further instructions',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Inputform(
              hintext: 'Email',
              obsure: false,
              profile: Icon(Icons.email),
              control: resetemail),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () async {
                try {
                  await _authservice.forgotpassowrd(resetemail.text);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              Text('Reset Password has been sent successfully'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Confirm'),
                            )
                          ],
                        );
                      });
                } on FirebaseAuthException catch (e) {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(e.toString()),
                        );
                      });
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Button(
                  input: 'Submit',
                ),
              )),
        ],
      ),
    );
  }
}
