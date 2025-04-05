import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/componets/textformforloginpage.dart';
import 'package:theisi_app/front%20_end_app/componets/button.dart';
import 'package:theisi_app/service/authservice.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required this.togglepages});

  final Function togglepages;
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController name = TextEditingController();
  final TextEditingController createpassowrd = TextEditingController();
  final TextEditingController email = TextEditingController();
  String error = '';
  bool showpassowd = true;

  final Authservice _auth = Authservice();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   title: Text(''),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: SafeArea(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'images/logo1.png',
                        width: 300,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Inventory Managment System ',
                        style: TextStyle(
                            fontFamily: 'cursive',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Inputform(
                          hintext: 'Employee Name',
                          obsure: false,
                          profile: Icon(Icons.person),
                          control: name,
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter a valid email';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Inputform(
                        hintext: 'Employee No.',
                        obsure: false,
                        profile: Icon(Icons.person),
                        control: email,
                        valid: (value) => value!.isEmpty
                            ? 'Enter your employee number'
                            : null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Inputform(
                          hintext: 'Password (min. 8 characters)',
                          obsure: showpassowd,
                          profile: Icon(Icons.lock),
                          control: createpassowrd,
                          eye: IconButton(
                              onPressed: () {
                                setState(() {
                                  showpassowd = !showpassowd;
                                });
                              },
                              icon: Icon(Icons.visibility)),
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password can't be null";
                            } else if (value.length < 8) {
                              return 'Your Password is to short';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.signup(
                                name.text, createpassowrd.text, email.text);
                            if (result == null) {
                              setState(() {
                                error = 'invalid email and password';
                              });
                            } else {
                              return;
                            }
                          }
                        },
                        child: Button(
                          input: 'Submit',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(error),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account?'),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.togglepages();
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.orange),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
