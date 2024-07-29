// ignore_for_file: implementation_imports

import 'package:auth_user/otp_auth/authfirebaseservices.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  static String verify = '';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController countryCode = TextEditingController();

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                './assets/images/loginimg.png',
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                onChanged: (value) {
                  phoneNumber = value;
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android_rounded),
                    hintText: 'Phone Number'),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  AuthService.sendOtp();
                },
                child: Container(
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
                  child: Center(
                    child: GestureDetector(
                      child: const InkWell(
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
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
