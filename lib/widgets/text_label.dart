import 'package:flutter/material.dart';

/// A reusable text label widget.
/// Allows for consistent styling across the app.
class CustomTextLabel extends StatelessWidget {
  final String text;
  const CustomTextLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
