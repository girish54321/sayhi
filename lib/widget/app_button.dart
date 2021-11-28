import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function()? function;
  final Widget? icon;
  final String label;
  const AppButton(
      {Key? key,
      required this.function,
      required this.icon,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: function, icon: icon ?? const Text(''), label: Text(label));
  }
}
