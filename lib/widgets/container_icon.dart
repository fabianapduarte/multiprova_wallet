import 'package:flutter/material.dart';

class ContainerIcon extends StatelessWidget {
  const ContainerIcon({super.key, required this.padding, required this.icon});

  final double padding;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: EdgeInsets.all(padding),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
