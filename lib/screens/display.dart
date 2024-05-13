import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  const Display({super.key, required this.title, required this.body});

  final Widget title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: title,
        shape: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1)),
      ),
      body: body,
    );
  }
}
