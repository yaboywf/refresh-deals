import 'package:flutter/material.dart';

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
          colorFilter:
              imagePath == "images/authentication_bg.jpg"
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
