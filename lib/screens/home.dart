import 'package:flutter/material.dart';
import 'package:multiprova_wallet/screens/display.dart';
import 'package:multiprova_wallet/widgets/logo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Display(
      title: Logo(
        alignment: MainAxisAlignment.start,
        fontSize: 22.0,
        iconSize: 26.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
