import 'package:flutter/material.dart';

const primaryColor =  Color(0xFFFF6F59);
const secondColor = Color(0xFFA8C686);


final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  focusColor: secondColor,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 16
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.black,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    hintStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: const TextStyle(
        color: Colors.black
    ),
  ),
  elevatedButtonTheme:  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.black12,
        disabledForegroundColor: Colors.black,
        foregroundColor: Colors.black,
        backgroundColor: primaryColor
    )
  ),


);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  focusColor: secondColor,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.white,
  ),
);


