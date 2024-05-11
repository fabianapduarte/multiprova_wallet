import 'package:flutter/material.dart';

enum ThemeApp {
  light,
  dark;

  ThemeMode get themeMode {
    switch (this) {
      case ThemeApp.light:
        return ThemeMode.light;
      case ThemeApp.dark:
        return ThemeMode.dark;
    }
  }
}
