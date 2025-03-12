import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class LoginScreen extends  StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _enableInterButton = false;
  String phoneNumber = "";

  getOTP() {
    PhoneAuthController.sendOTP(context, phoneNumber);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Padding(
              padding:  const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InternationalPhoneNumberInput(
                        onInputChanged: (value) {
                          setState(() {
                            phoneNumber = value.phoneNumber!;
                          });
                        },
                      onInputValidated: (value) {
                          setState(() {
                            _enableInterButton = value;
                          });
                      },
                      formatInput: true,
                      autoFocus: true,
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        useEmoji: true
                      ),
                      inputDecoration: InputDecoration(
                          labelText: "Номер телефона",
                          hintText: "Введите номер телефона",
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.black
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                      ),
                    )
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _enableInterButton ? () {getOTP();} : null,
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.black12,
                            disabledForegroundColor: Colors.black,
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.amber,
                          ),
                          child: const Text(
                              "Получить код",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
      )
    );
  }
}