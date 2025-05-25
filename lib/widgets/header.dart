import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  /// Build a header with the project logo.
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
