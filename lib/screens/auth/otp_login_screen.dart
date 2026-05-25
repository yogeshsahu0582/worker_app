import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class OTPLoginScreen extends StatefulWidget {
  const OTPLoginScreen({super.key});

  @override
  State<OTPLoginScreen> createState() => _OTPLoginScreenState();
}

class _OTPLoginScreenState extends State<OTPLoginScreen> {
  final phoneController = TextEditingController();

  final otpController = TextEditingController();

  String verificationId = "";

  bool otpSent = false;

  bool loading = false;

  Future<void> sendOTP() async {
    setState(() {
      loading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",

      verificationCompleted: (credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },

      verificationFailed: (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? "")));
      },

      codeSent: (id, token) {
        verificationId = id;

        setState(() {
          otpSent = true;

          loading = false;
        });
      },

      codeAutoRetrievalTimeout: (id) {},
    );
  }

  Future<void> verifyOTP() async {
    setState(() {
      loading = true;
    });

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,

      smsCode: otpController.text,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,

      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 50),

            const Text(
              "PA Worker Login",

              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: phoneController,

              keyboardType: TextInputType.phone,

              decoration: InputDecoration(
                hintText: "Enter mobile number",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (otpSent)
              TextField(
                controller: otpController,

                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  hintText: "Enter OTP",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),

                onPressed: loading
                    ? null
                    : otpSent
                    ? verifyOTP
                    : sendOTP,

                child: loading
                    ? const CircularProgressIndicator()
                    : Text(
                        otpSent ? "Verify OTP" : "Send OTP",

                        style: const TextStyle(
                          color: Colors.black,

                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
