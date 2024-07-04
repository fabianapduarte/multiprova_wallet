import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.alignment, required this.fontSize, required this.iconSize});

  final MainAxisAlignment alignment;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(Icons.wallet_outlined, color: Theme.of(context).colorScheme.primary, size: iconSize),
        ),
        Text(
          'MultiprovaWallet',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
