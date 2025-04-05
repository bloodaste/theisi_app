import 'package:firebase_auth/firebase_auth.dart';
import 'package:theisi_app/front%20_end_app/models/usermodel.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Usermodel? useridanon(User? user) {
    return user != null ? Usermodel(userid: user.uid) : null;
  }

  Stream<Usermodel?> get userfunction {
    return _auth.authStateChanges().map(useridanon);
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
      String email, String password, String employeenumber) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      return useridanon(user);
    } catch (e) {
      print("Signup error: $e");
      return null;
    }
  }

  Future<Usermodel?> signin(String email, String passowrd) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: passowrd);

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

  // Future otp()async{
  //   try{
  //     await _auth.s
  //   }
  // }
}
