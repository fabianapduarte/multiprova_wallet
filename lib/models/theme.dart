import 'package:flutter/material.dart';
import 'package:multiprova_wallet/utils/colors.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.dark;

  ThemeMode get themeMode => _theme;

  void handleTheme(ThemeMode newTheme) {
    _theme = newTheme;
    notifyListeners();
  }

  ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: blue,
        onPrimary: blue,
        background: white,
        onBackground: grayLight,
        error: red,
        outline: blueLight,
        surface: blueLight,
        onSurface: gray,
      ),
      dialogBackgroundColor: white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, color: gray),
        bodyMedium: TextStyle(fontSize: 16, color: gray),
        bodySmall: TextStyle(fontSize: 14, color: gray),
        headlineLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: blue),
        headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: blue),
        headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: blue),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: gray),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: gray),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: gray),
        labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: white),
      ),
    );
  }

  ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: blueDark,
        onPrimary: white,
        background: black,
        onBackground: grayDark,
        error: red,
        outline: grayDark,
        surface: grayDark,
        onSurface: white,
      ),
      dialogBackgroundColor: grayDark,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, color: white),
        bodyMedium: TextStyle(fontSize: 16, color: white),
        bodySmall: TextStyle(fontSize: 14, color: white),
        headlineLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: white),
        headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: white),
        headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: white),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: white),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: white),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: white),
        labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: white),
      ),
    );
  }
}
