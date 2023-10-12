import 'package:flutter/material.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
    super.key,
    required this.name,
    required this.onpressed,
    required this.icon,
  });
  final String name;
  final Function() onpressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onpressed,
      icon: Icon(icon),
      label: Text(name),
    );
  }
}