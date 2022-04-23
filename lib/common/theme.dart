import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(


      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(subtitle1: TextStyle(color: Colors.black)),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(20),
        iconColor: Colors.white,

        // filled: true,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
      ),
   );
}
