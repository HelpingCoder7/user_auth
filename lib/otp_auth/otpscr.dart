import 'package:auth_user/otp_auth/authfirebaseservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class otpsrc extends StatefulWidget {
  const otpsrc({super.key});

  @override
  State<otpsrc> createState() => _otpsrcState();
}

// ignore: camel_case_types
class _otpsrcState extends State<otpsrc> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Verify OTP',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                './assets/images/otpimg.jpg',
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                onChanged: (value) {
                  otp = value;
                },
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.numbers_sharp), hintText: 'OTP'),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.yellowAccent])),
                child: GestureDetector(
                  onTap: () {
                    AuthService.checkOtp(context, otp);
                  },
                  child: const Center(
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
