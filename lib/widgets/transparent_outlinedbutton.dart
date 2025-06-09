import 'package:flutter/material.dart';

class TransparentOutlinedbutton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Size minimumSize;
  const TransparentOutlinedbutton({super.key, required this.onPressed, required this.text, this.minimumSize = const Size(300, 30)});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        minimumSize: minimumSize,
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
