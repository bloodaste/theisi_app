import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:theisi_app/firebase_options.dart';
import 'package:theisi_app/front%20_end_app/models/usermodel.dart';
import 'package:theisi_app/service/authservice.dart';
import 'package:theisi_app/wrapperifaccountlogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("🔥 Firebase successfully initialized!");
  } catch (e) {
    print("❌ Firebase initialization failed: $e");
  }
  runApp(const ThesisAPP());
}

class ThesisAPP extends StatelessWidget {
  const ThesisAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usermodel?>.value(
      value: Authservice().userfunction,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Loginvalidation(),
      ),
    );
  }
}
