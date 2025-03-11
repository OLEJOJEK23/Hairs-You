import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/HomeScreen/HomeScreen.dart';
import '../features/InputOTPCode/InputOTPCodeScreen.dart';

class PhoneAuthController {

  static final _auth = FirebaseAuth.instance;

  static Future<void> sendOTP(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {

        },

        verificationFailed: (FirebaseAuthException error) {
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                      content: Text
                        (error.message ?? "Что-то пошло не так"
                      )
                  )
              );
        },

        codeSent: (String verificationId, int? forceResendingToken) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InputOTPCodeScreen(
            phoneNumber:phoneNumber,
            verificationID: verificationId,
              ),
            ),
          );
        },

        codeAutoRetrievalTimeout: (String verificationId) {

        }

      );
    }
    on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(
                content: Text
                  (e.message ?? "Что-то пошло не так"
                )
            )
        );
    }
    catch (e) {
      debugPrint(e.toString());
    }
    finally {

    }

  }

  static Future<void> virifyOTP(BuildContext context, String smsCode, String verificationID) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      if(!context.mounted) return;

      Navigator.of(context).push( MaterialPageRoute(
          builder: (context) => const HomeScreen()));
    }
    on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(
                content: Text
                  (e.message ?? "Что-то пошло не так"
                )
            )
        );
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

}