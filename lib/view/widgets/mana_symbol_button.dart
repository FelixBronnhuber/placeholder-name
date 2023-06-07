import 'package:flutter/material.dart';

class ManaSymbolButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;
  final bool isActive;

  const ManaSymbolButton({
    super.key,
    required this.asset,
    required this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? Colors.black : Colors.transparent,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(1000.0),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(asset),
      ),
    );
  }
}