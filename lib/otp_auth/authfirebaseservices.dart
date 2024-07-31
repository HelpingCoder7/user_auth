import 'dart:developer';
import 'package:auth_user/otp_auth/otpscr.dart';
import 'package:auth_user/quiz/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  static String? _verify;
  static Future<void> sendOtp(BuildContext context, String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        log('Verification code sent');

        _verify = verificationId;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const otpsrc()),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Auto retrieval timeout');
      },
    );
  }

  static Future<void> checkOtp(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: _verify!, smsCode: otp);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        log('otp verified');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizScreen()));
      } else {
        log('otp verification failed');
      }
    } catch (e) {
      log('some error occurred');
    }
  }
}

class GoogleHandler {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

     
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        log('signed in');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizScreen()),
        );
      } else {
        log('Sign in failed');
      }
    } catch (e) {
      log('Error signing in with Google: $e');
    }
  }
}
