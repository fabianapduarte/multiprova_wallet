import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.label, this.icon, required this.onPressed});

  final String label;
  final Widget? icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          )),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12.0)),
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary)),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: icon,
          ),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
