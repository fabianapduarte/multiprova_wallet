import 'package:flutter/material.dart';

class CardOutlined extends StatelessWidget {
  const CardOutlined({super.key, required this.body, required this.width});

  final Widget body;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.all(0),
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: width,
          child: body,
        ),
      ),
    );
  }
}
