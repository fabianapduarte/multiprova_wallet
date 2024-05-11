import 'package:flutter/material.dart';
import 'package:multiprova_wallet/enum/enum_theme_app.dart';
import 'package:multiprova_wallet/utils/colors.dart';

class ThemeModel extends ChangeNotifier {
  ThemeApp _theme = ThemeApp.light;

  ThemeMode get themeMode => _theme.themeMode;

  void handleTheme(ThemeApp newTheme) {
    _theme = newTheme;
    notifyListeners();
  }

  ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: blue,
          onPrimary: white,
          background: white,
          onBackground: grayLight,
          error: red,
          outline: blueLight,
          surface: blueLight,
        ),
        textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: gray),
            bodyMedium: TextStyle(fontSize: 16, color: gray),
            bodySmall: TextStyle(fontSize: 14, color: gray),
            headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: blue),
            titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: gray),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: gray),
            titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: gray)));
  }

  ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: blueDark,
          onPrimary: white,
          background: black,
          onBackground: white,
          error: red,
          outline: grayDark,
          surface: grayDark,
        ),
        textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: white),
            bodyMedium: TextStyle(fontSize: 16, color: white),
            bodySmall: TextStyle(fontSize: 14, color: white),
            headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: white),
            titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: white),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: white),
            titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: white)));
  }
}
