import 'package:flutter/material.dart';

class Snackbar {
  const Snackbar({required this.text});

  final String text;

  SnackBar build(BuildContext context) {
    return SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      closeIconColor: Theme.of(context).colorScheme.onSurface,
      content: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      duration: const Duration(seconds: 5),
    );
  }
}
