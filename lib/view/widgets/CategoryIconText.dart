import 'package:flutter/material.dart';

class CategoryIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryIconText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(icon),
      Text(text, style: const TextStyle(fontWeight: FontWeight.bold))
    ]);
  }
}
