import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/componets/button.dart';
import 'package:theisi_app/front%20_end_app/componets/loadinganimation.dart';
import 'package:theisi_app/front%20_end_app/pages/forgotpassword.dart';
import 'package:theisi_app/front%20_end_app/componets/textformforloginpage.dart';
// import 'package:theisi_app/auth/signuppage.dart';
import 'package:theisi_app/service/authservice.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key, required this.togglepages});

  final Function togglepages;
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final Authservice _auth = Authservice();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController passoword = TextEditingController();
  String error = '';
  bool showpassowd = true;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.grey[100],
            body: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: SafeArea(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/logo1.png',
                          width: 300,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Inventory Management System',
                          style: TextStyle(
                              fontFamily: 'cursive',
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'oswald'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Inputform(
                            hintext: 'Name',
                            obsure: false,
                            profile: Icon(Icons.person),
                            control: name,
                            valid: (value) {
                              if (value == null) {
                                return 'enter valid email';
                              } else if (!value.contains('@')) {
                                return 'invalid email';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Inputform(
                            hintext: 'Password',
                            obsure: showpassowd,
                            profile: Icon(Icons.lock),
                            control: passoword,
                            eye: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  showpassowd = !showpassowd;
                                });
                              },
                            ),
                            valid: (value) {
                              if (value == null) {
                                return 'enter a valid password';
                              } else if (value.length < 8) {
                                return 'wrong password ';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Forgotpasswordpage();
                                  }));
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.signin(name.text, passoword.text);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Invalid email or password';
                                });
                              }
                            }
                          },
                          child: Button(
                            input: 'Login',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Havent have An Account?"),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.togglepages();
                              },
                              child: Text(
                                "Contact Admin",
                                style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                ),
              ),
            ));
  }
}
