import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:pinput/pinput.dart';

class InputOTPCodeScreen extends  StatefulWidget {
  const InputOTPCodeScreen ({super.key, required this.phoneNumber,required this.verificationID});

  final String phoneNumber;
  final String verificationID;


  @override
  State<InputOTPCodeScreen > createState() => _InputOTPCodeScreenState();
}

class _InputOTPCodeScreenState extends State<InputOTPCodeScreen > {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Введите код"),
      ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding:  const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                   Text(
                       "Шестизначный код был отправлен на номер - ${widget.phoneNumber} , введите его ниже",
                     style: const TextStyle(
                       fontWeight: FontWeight.normal,
                       fontSize: 16,
                       color: Colors.black,
                     ),
                   ),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                    child: Pinput(
                      length: 6,
                      onCompleted: (value) {
                        AuthController.virifyOTP(context, value, widget.verificationID);

                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}