import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<void> sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+919827763713',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        log('Verification code sent to ');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Auto retrieval timeout');
      },
    );
  }
}
