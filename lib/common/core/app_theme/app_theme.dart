import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey[200],
    fontFamily: 'Montserrat Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat Regular'),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          foregroundColor: Colors.white),
    ),
  );
}
