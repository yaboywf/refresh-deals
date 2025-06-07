import 'package:flutter/material.dart';

// Create a custom SnackBar widget
class CustomSnackBar extends SnackBar {
  CustomSnackBar({super.key, required String text})
    : super(
        content: Text(text, style: TextStyle(color: Colors.black)),
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromRGBO(233, 218, 200, 1.0),
      );
}
