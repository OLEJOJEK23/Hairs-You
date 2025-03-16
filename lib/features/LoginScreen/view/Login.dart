import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/Auth_contoroller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

@RoutePage()
class LoginScreen extends  StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _enableInterButton = false;
  String phoneNumber = "";

  getOTP() {
    AuthController.sendOTP(context, phoneNumber);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      selectorTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                      ),
                      spaceBetweenSelectorAndTextField: 0,
                      searchBoxDecoration: const InputDecoration(
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                        ),
                        labelText: "Телефонный код страны",
                        hintStyle:  TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        labelStyle:  TextStyle(
                            color: Colors.black
                        ),
                      ),
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
                            fontSize: 16
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
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child:  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed:  () async {
                            await AuthController().loginWithGoogle(context);
                          } ,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.yellow.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                          icon: Image.asset(
                            "assets/images/google_logo.png",
                            width: 20,
                            height: 20,
                          ),
                          label: const Text(
                            "Войти с помощью Google",
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
    );
  }
}