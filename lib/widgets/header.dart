import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'images/logo.png',
        width: 280,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}