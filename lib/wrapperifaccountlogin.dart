import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theisi_app/auth/authentication.dart';
import 'package:theisi_app/front%20_end_app/models/usermodel.dart';
import 'package:theisi_app/homepage/homepage.dart';

class Loginvalidation extends StatelessWidget {
  const Loginvalidation({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usermodel?>(context);

    if (user == null) {
      return Authentication();
    } else {
      return NavBar();
    }
  }
}


// logic wethear the user is log in or not 
 