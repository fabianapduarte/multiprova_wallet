import 'package:flutter/material.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/screens/history.dart';
import 'package:multiprova_wallet/screens/home.dart';
import 'package:multiprova_wallet/screens/store.dart';
import 'package:multiprova_wallet/screens/swap.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key, required this.screenActive});

  final NavigationBarActions screenActive;

  Color iconColor(BuildContext context, bool isActive) {
    if (isActive) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Theme.of(context).colorScheme.onSurface;
    }
  }

  Widget getNavigationButton(BuildContext context, NavigationBarActions action, IconData icon, Widget page) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      icon: Icon(icon),
      color: iconColor(context, screenActive == action),
      iconSize: 28.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 16.0, left: 32.0, right: 32.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Theme.of(context).colorScheme.surface,
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: getNavigationButton(context, NavigationBarActions.home, Icons.home_rounded, const Home()),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: getNavigationButton(context, NavigationBarActions.store, Icons.store_rounded, const Store()),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: getNavigationButton(context, NavigationBarActions.swap, Icons.swap_horiz_rounded, const Swap()),
              ),
              getNavigationButton(context, NavigationBarActions.history, Icons.history_rounded, const History()),
            ],
          ),
        ),
      ],
    );
  }
}
