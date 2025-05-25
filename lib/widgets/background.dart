import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

/// A widget that provides a background image for its child widget.
/// 
/// The [Background] widget displays an image behind its child widget,
/// with an optional padding around the child. It also allows a custom
/// image path to be specified. If the default authentication background
/// image is used, a soft light color filter is applied.
class Background extends StatelessWidget {
  final Widget child;
  final String imagePath;
  final double padding;

  const Background({
    super.key,
    required this.child,
    this.imagePath = "images/authentication_bg.jpg",
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: imagePath == "images/authentication_bg.jpg"
              ? ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 1.0),
                  BlendMode.softLight,
                )
              : null,
        ),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
