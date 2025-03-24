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
    final theme = Theme.of(context);
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
                      textStyle: theme.textTheme.labelLarge,
                      selectorTextStyle: theme.textTheme.labelLarge,
                      spaceBetweenSelectorAndTextField: 0,
                      searchBoxDecoration:  InputDecoration(
                        focusColor: theme.inputDecorationTheme.focusColor,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        labelText: "Телефонный код страны",
                        hintStyle: theme.textTheme.bodyMedium,
                        labelStyle: theme.textTheme.labelLarge,
                      ),
                      formatInput: true,
                      autoFocus: true,
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        showFlags: true
                      ),
                      inputDecoration: InputDecoration(
                          labelText: "Номер телефона",
                          hintText: "Введите номер телефона",
                          hintStyle: theme.textTheme.bodyMedium,
                          labelStyle: theme.textTheme.labelLarge,
                          focusedBorder: theme.inputDecorationTheme.focusedBorder,
                          border: theme.inputDecorationTheme.border
                      ),
                    )
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _enableInterButton ? ()
                          {
                            getOTP();
                          }
                          : null,
                          style: theme.elevatedButtonTheme.style,
                          child:  Text(
                              "Получить код",
                            style: theme.textTheme.bodyMedium,
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
                          style: theme.elevatedButtonTheme.style?.copyWith(
                            backgroundColor: WidgetStatePropertyAll(theme.focusColor),
                          ),
                          icon: Image.asset(
                            "assets/images/google_logo.png",
                            width: 20,
                            height: 20,
                          ),
                          label:  Text(
                            "Войти с помощью Google",
                            style: theme.textTheme.bodyMedium,
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