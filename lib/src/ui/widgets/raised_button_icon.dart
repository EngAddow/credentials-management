import 'package:flutter/material.dart';

class RaisedButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  const RaisedButtonIcon({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      padding: const EdgeInsets.all(8.5),
      color: Theme.of(context).colorScheme.primary.withAlpha(110),
      // Colors.blueGrey.shade200,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
