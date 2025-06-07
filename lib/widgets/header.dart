import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  /// Build a header with the project logo.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: null,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
        child: Align(alignment: Alignment.topLeft, child: Image.asset('images/logo.png', width: 280, height: 100, fit: BoxFit.contain)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
