import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/models/theme.dart';
import 'package:multiprova_wallet/screens/login.dart';
import 'package:multiprova_wallet/widgets/navigation_bottom_bar.dart';
import 'package:provider/provider.dart';

class Display extends StatelessWidget {
  const Display({
    super.key,
    required this.title,
    required this.body,
    required this.screenActive,
    required this.automaticallyImplyLeading,
  });

  final Widget title;
  final Widget body;
  final NavigationBarActions screenActive;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: title,
        shape: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1)),
        actions: <Widget>[
          Consumer<ThemeModel>(builder: (context, theme, child) {
            if (theme.themeMode.name == ThemeMode.dark.name) {
              return IconButton(
                onPressed: () {
                  theme.handleTheme(ThemeMode.light);
                },
                icon: Icon(Icons.light_mode_outlined),
              );
            } else {
              return IconButton(
                onPressed: () {
                  theme.handleTheme(ThemeMode.dark);
                },
                icon: Icon(Icons.dark_mode_outlined),
              );
            }
          }),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        forceMaterialTransparency: true,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 88.0),
          child: body,
        ),
      ),
      bottomNavigationBar: NavigationBottomBar(screenActive: screenActive),
      extendBody: true,
    );
  }
}
