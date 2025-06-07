import 'package:flutter/material.dart';

class TransparentOutlinedbutton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const TransparentOutlinedbutton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(300, 30),
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
