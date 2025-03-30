import 'package:flutter/material.dart';

const primaryColor = Color(0xFFFF6F59);
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
        color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
    labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusColor: Colors.black,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.black),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    hintStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: const TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.black12,
        disabledForegroundColor: Colors.black,
        foregroundColor: Colors.black,
        backgroundColor: primaryColor),
  ),
  searchBarTheme: const SearchBarThemeData(
    backgroundColor: WidgetStatePropertyAll(Colors.black12),
    surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
    shadowColor: WidgetStatePropertyAll(Colors.transparent),
    constraints: BoxConstraints(minHeight: 46),
    textStyle: WidgetStatePropertyAll(
      TextStyle(
          color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
    ),
    hintStyle: WidgetStatePropertyAll(
      TextStyle(
          color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  focusColor: secondColor,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    hintStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: const TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.white12,
          disabledForegroundColor: Colors.white,
          foregroundColor: Colors.white,
          backgroundColor: primaryColor)),
  searchBarTheme: const SearchBarThemeData(
    backgroundColor: WidgetStatePropertyAll(Colors.white10),
    surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
    shadowColor: WidgetStatePropertyAll(Colors.transparent),
    constraints: BoxConstraints(minHeight: 46),
    textStyle: WidgetStatePropertyAll(
      TextStyle(
          color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
    ),
    hintStyle: WidgetStatePropertyAll(
      TextStyle(
          color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
    ),
  ),
);

final boxDecoration = BoxDecoration(
  border: Border.all(color: primaryColor),
  borderRadius: BorderRadius.circular(15),
);
