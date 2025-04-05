import 'package:flutter/material.dart';
import 'package:theisi_app/auth/login.dart';
import 'package:theisi_app/auth/signuppage.dart';
// import 'package:theisi_app/auth/signuppage.dart';
// import 'package:theisi_app/homepage/homepage.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showgin = true;

  void togglePage() {
    setState(() {
      showgin = !showgin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showgin) {
      return Loginpage(togglepages: togglePage);
    } else {
      return Signup(togglepages: togglePage);
    }
  }
}
