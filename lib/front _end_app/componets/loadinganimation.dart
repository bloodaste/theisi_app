import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  final VoidCallback onAnimationComplete; // Add this callback

  const Loader({
    super.key,
    required this.onAnimationComplete, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.network(
          'https://lottie.host/ef93688f-6150-4f1e-b4a0-5b4c3bad2266/8yVLdr6E8V.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
          onLoaded: (composition) {
            // Wait for animation duration, then trigger callback
            Future.delayed(composition.duration, onAnimationComplete);
          },
        ),
      ),
    );
  }
}
