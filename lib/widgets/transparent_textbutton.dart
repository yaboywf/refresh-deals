import 'package:flutter/material.dart';

/// A custom text button that can be used to create text buttons that are
/// visually appealing and easy to use.
///
/// The [text] parameter is the text that will be displayed on the button.
///
/// The [onPressed] parameter is an optional callback that will be called when
/// the button is pressed.
///
/// The [bold] parameter is an optional boolean that determines whether the
/// text on the button should be bold or not. The default value is false.
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool bold;

  const CustomTextButton({super.key, required this.text, this.onPressed, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
        // Make the button transparent so that it doesn't take up any space.
        backgroundColor: Colors.transparent,
        // Make the button as small as possible.
        visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      ),
      child: Text(
        text,
        // If the [bold] parameter is true, make the text bold.
        style: TextStyle(color: Colors.black, fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
