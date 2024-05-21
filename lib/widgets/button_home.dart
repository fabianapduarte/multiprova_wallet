import 'package:flutter/material.dart';

class ButtonHome extends StatelessWidget {
  const ButtonHome({super.key, required this.label, required this.srcIcon, required this.onPressed});

  final String label;
  final String srcIcon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)),
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: (MediaQuery.sizeOf(context).width / 2) - 53.0,
        height: 80.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Image.asset(
                  'assets/$srcIcon',
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
