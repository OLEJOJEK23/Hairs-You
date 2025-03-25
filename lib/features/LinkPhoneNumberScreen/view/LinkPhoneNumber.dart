import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/controllers/Link_account_controller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

@RoutePage()
class LinkPhoneNumber extends  StatefulWidget {
  const LinkPhoneNumber({super.key});


  @override
  State<LinkPhoneNumber> createState() => _LinkPhoneNumberState();
}

class _LinkPhoneNumberState extends State<LinkPhoneNumber> {

  bool _enableInterButton = false;
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Связать аккаунт"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:  const EdgeInsets.all(16.0),
          child: Column(
            children: [

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
                      async {
                        await LinkAccountController.sendOTP(context, phoneNumber);
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
            ],
          ),
        ),
      ),
    );
  }
}