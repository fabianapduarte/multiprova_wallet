import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.wallet_outlined, color: Theme.of(context).colorScheme.primary, size: 28)),
            Text('MultiprovaWallet', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ],
        ),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        shape: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1)),
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
