import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:theisi_app/front%20_end_app/models/usermodel.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _accountloc = FirebaseFirestore.instance;

  Usermodel? useridanon(User? user) {
    return user != null ? Usermodel(userid: user.uid) : null;
  }

  Stream<Usermodel?> get userfunction {
    return _auth.authStateChanges().map(useridanon);
  }

  String hasspaswrod(password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // annonymous login
  Future signinanonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();

      User? loginanony = result.user;

      return useridanon(loginanony);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signup function
  Future signout() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Usermodel?> signup(
    String name,
    String password,
    String email,
    String role,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = result.user;

      //account type to determin the account type of the user
      await _accountloc.collection('useraccount').doc(user!.uid).set({
        'email': email,
        'password': hasspaswrod(password),
        'Name': name,
        'role': role,
      });
      return useridanon(user);
    } catch (e) {
      print("Signup error: $e");
      return null;
    }
  }

  Future<Usermodel?> signin(String email, String passowrd) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: passowrd.trim(),
      );

      User? user = result.user;
      return useridanon(user);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future forgotpassowrd(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return (e.toString());
    }
  }

  Future<Map<String, dynamic>> getuserrole() async {
    User? user = _auth.currentUser;

    try {
      if (user != null) {
        DocumentSnapshot snapshot =
            await _accountloc.collection('useraccount').doc(user.uid).get();
        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print(e);
    }
    return {};
  }
  // Future otp()async{
  //   try{
  //     await _auth.s
  //   }
  // }
}
