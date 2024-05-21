import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({super.key, required this.title, required this.actions, required this.textBody});

  final String title;
  final List<Widget> actions;
  final String textBody;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(textBody, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          ],
        ),
      ),
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      scrollable: true,
    );
  }
}
