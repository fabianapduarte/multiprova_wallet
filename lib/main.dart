import 'package:flutter/material.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MultiprovaWallet',
      themeMode: ThemeMode.light,
      theme: CustomTheme.lightThemeData(context),
      darkTheme: CustomTheme.darkThemeData(context),
      home: const Home(),
    );
  }
}
