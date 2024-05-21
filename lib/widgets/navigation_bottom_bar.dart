import 'package:flutter/material.dart';
import 'package:multiprova_wallet/enums/navigation_bar_actions.dart';
import 'package:multiprova_wallet/screens/home.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      margin: EdgeInsets.only(bottom: 16.0, left: 32.0, right: 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            icon: Icon(Icons.home_rounded),
            color: iconColor(context, screenActive == NavigationBarActions.home),
            iconSize: 28.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.store_rounded),
            color: iconColor(context, screenActive == NavigationBarActions.store),
            iconSize: 28.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.swap_horiz_rounded),
            color: iconColor(context, screenActive == NavigationBarActions.swap),
            iconSize: 28.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history_rounded),
            color: iconColor(context, screenActive == NavigationBarActions.history),
            iconSize: 28.0,
          ),
        ],
      ),
    );
  }
}
