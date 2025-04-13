import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:theisi_app/auth/authentication.dart';
import 'package:theisi_app/front%20_end_app/pages/onboardscreens/onboardscreen.dart';
import 'package:theisi_app/front%20_end_app/pages/onboardscreens/onboardscreen2.dart';
import 'package:theisi_app/front%20_end_app/pages/onboardscreens/onboardscreen3.dart';
import 'package:theisi_app/wrapperifaccountlogin.dart';

class Onboardscreen extends StatefulWidget {
  const Onboardscreen({super.key});

  @override
  State<Onboardscreen> createState() => _OnboardscreenState();
}

class _OnboardscreenState extends State<Onboardscreen> {
  final PageController _controller = PageController();
  bool onlastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onlastpage = (value == 2);
              });
            },
            children: [
              Onboardscreen1(),
              Onboardscreen2(),
              Onboardscreen3(),
            ],
          ),
          Container(
            alignment: Alignment(0.70, -.90),
            child: GestureDetector(
              onTap: () {
                _controller.jumpToPage(2);
              },
              child: Text(
                'Skip',
              ),
            ),
          ),
          Container(
            alignment: Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Text('back'),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onlastpage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Authentication()));
                        },
                        child: Text('Done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Next'),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
