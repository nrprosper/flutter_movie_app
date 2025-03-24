import 'package:flutter/material.dart';
import '../colors.dart';

class BadgePill extends StatelessWidget {
  final String text;

  const BadgePill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: MColors.grey,
        ),
      ),
    );
  }
}
