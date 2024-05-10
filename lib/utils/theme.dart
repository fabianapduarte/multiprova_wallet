import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 63, 114, 175),
          onPrimary: Color.fromARGB(255, 250, 252, 255),
          background: Color.fromARGB(255, 250, 252, 255),
          onBackground: Color.fromARGB(255, 190, 200, 210),
          error: Color.fromARGB(255, 148, 47, 47),
          outline: Color.fromARGB(255, 223, 234, 246),
          surface: Color.fromARGB(255, 223, 234, 246),
        ),
        textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Color.fromARGB(255, 60, 66, 75)),
            bodyMedium: TextStyle(fontSize: 16, color: Color.fromARGB(255, 60, 66, 75)),
            bodySmall: TextStyle(fontSize: 14, color: Color.fromARGB(255, 60, 66, 75)),
            headlineLarge:
                TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 63, 114, 175)),
            titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 60, 66, 75)),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 60, 66, 75)),
            titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 60, 66, 75))));
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Color.fromARGB(255, 43, 78, 120),
          onPrimary: Color.fromARGB(255, 250, 252, 255),
          background: Color.fromARGB(255, 6, 11, 17),
          onBackground: Color.fromARGB(255, 250, 252, 255),
          error: Color.fromARGB(255, 148, 47, 47),
          outline: Color.fromARGB(255, 27, 39, 53),
          surface: Color.fromARGB(255, 27, 39, 53),
        ),
        textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Color.fromARGB(255, 250, 252, 255)),
            bodyMedium: TextStyle(fontSize: 16, color: Color.fromARGB(255, 250, 252, 255)),
            bodySmall: TextStyle(fontSize: 14, color: Color.fromARGB(255, 250, 252, 255)),
            headlineLarge:
                TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 250, 252, 255)),
            titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 250, 252, 255)),
            titleMedium:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 250, 252, 255)),
            titleSmall:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 250, 252, 255))));
  }
}
