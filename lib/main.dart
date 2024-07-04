import 'package:flutter/material.dart';
import 'package:multiprova_wallet/models/theme.dart';
import 'package:multiprova_wallet/models/w3m_service.dart';
import 'package:multiprova_wallet/screens/login.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (context) => ThemeModel(),
//     child: const MultiprovaWallet(),
//   ));
// }

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeModel()),
      ChangeNotifierProvider(create: (context) => W3mServiceModel()),
    ],
    child: const MultiprovaWallet(),
  ));
}

class MultiprovaWallet extends StatelessWidget {
  const MultiprovaWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, theme, child) {
      return MaterialApp(
        title: 'MultiprovaWallet',
        themeMode: theme.themeMode,
        theme: theme.lightThemeData(context),
        darkTheme: theme.darkThemeData(context),
        home: Login(),
      );
    });
  }
}
