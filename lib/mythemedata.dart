import 'package:flutter/material.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xff5D9CEC),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff060E1E)),
    canvasColor: const Color(0xffFFFFFF),
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xff303030),
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
      headline2: TextStyle(
          color: Color(0xffFFFFFF),
          fontWeight: FontWeight.bold,
          fontSize: 30
      ),
    )
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xff5D9CEC),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xffDFECDB)),
    canvasColor: const Color(0xff141922),
    scaffoldBackgroundColor: const Color(0xff060E1E),
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Color(0xffFFFFFF),
          fontWeight: FontWeight.bold,
          fontSize: 18
      ),
      headline2: TextStyle(
          color: Color(0xff303030),
          fontWeight: FontWeight.bold,
          fontSize: 30
      ),
    )
  );
}
