import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/InputOTPCode/InputOTPCodeScreen.dart';

class AuthController {
  static final _auth = FirebaseAuth.instance;

  Future<void> sendOTP(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text(error.message ?? "Что-то пошло не так")));
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InputOTPCodeScreen(
                  phoneNumber: phoneNumber,
                  verificationID: verificationId,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(e.message ?? "Что-то пошло не так")));
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  Future<void> virifyOTP(
      BuildContext context, String smsCode, String verificationID) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      if (!context.mounted) return;
      context.router.replaceNamed("/");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(e.message ?? "Что-то пошло не так")));
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      await _auth.signInWithCredential(credential);
      if (!context.mounted) return;
      context.router.replaceNamed("/");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(e.message ?? "Что-то пошло не так")));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
