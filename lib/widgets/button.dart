// widgets/button.dart
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final Color bgColor;

  const Button({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.bgColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 44,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
