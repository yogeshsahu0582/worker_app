import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/otp_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const OTPLoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              height: 120,

              width: 120,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(30),
              ),

              child: const Icon(
                Icons.delivery_dining,

                size: 70,

                color: Colors.black,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "PA Worker",

              style: TextStyle(
                fontSize: 35,

                fontWeight: FontWeight.bold,

                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your Personal Assistant",

              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
