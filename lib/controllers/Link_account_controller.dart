import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/InputOTPCode/InputOTPCodeScreen.dart';

class LinkAccountController {

  static final _auth = FirebaseAuth.instance;
  final user = _auth.currentUser;

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

   Future<void> virifyOTP(BuildContext context, String smsCode, String verificationID) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: smsCode);
      await user?.linkWithCredential(credential);
      if(!context.mounted) return;
      context.router.replaceNamed("/settings");
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

  Future<void> linkWithGoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken:googleAuth?.idToken,
          accessToken: googleAuth?.accessToken
      );
      await user?.linkWithCredential(credential);
    }
    on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(
                content: Text(e.message ?? "Что-то пошло не так"
                )
            )
        );
    }
  }
}








