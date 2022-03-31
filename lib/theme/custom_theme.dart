import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Cairo',
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.black87,
      fontFamily: 'Cairo',
    );
  }
}
