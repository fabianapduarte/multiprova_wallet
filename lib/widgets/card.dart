import 'package:flutter/material.dart';

class CardFilled extends StatelessWidget {
  const CardFilled({super.key, required this.body, required this.width});

  final Widget body;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.all(0),
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: width,
          child: body,
        ),
      ),
    );
  }
}
