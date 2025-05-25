import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Scaffold that contains the login page
    return Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            // Aligns the widgets in the column to the start on the cross axis (horizontal axis)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: 150),
              // Centered text that says "Login"
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextLabel(text: "Username"),
              // Text field for the user to enter their username
              CustomTextField(
                controller: usernameController,
                hintText: 'Enter Username',
                obscureText: false,
              ),
              SizedBox(height: 20),
              TextLabel(text: "Password"),
              // Text field for the user to enter their password
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter Password',
                obscureText: true,
                maxLines: 1,
              ),
              SizedBox(height: 20),
              // Centered button that says "Login"
              Center(
                child: OutlinedButton(
                  onPressed:
                      () => Navigator.pushReplacementNamed(
                        context,
                        // If the username is "shop", navigate to the shop home page
                        usernameController.text == "shop" ? '/shop_home' : '/buyer_home',
                      ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(300, 30),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Centered text that says "Forgotten your Password?"
              Align(
                alignment: Alignment.center,
                child: CustomTextButton(
                  text: "Forgotten your Password?",
                  bold: true,
                ),
              ),
              // Centered text that says "New to Refresh Deals? Create an account!" and navigates to the register page when pressed
              Align(
                alignment: Alignment.center,
                child: CustomTextButton(
                  text: "New to Refresh Deals? Create an account!",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
        // Make the button transparent so that it doesn't take up any space.
        backgroundColor: Colors.transparent,
        // Make the button as small as possible.
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
      child: Text(
        text,
        // If the [bold] parameter is true, make the text bold.
        style: TextStyle(
          color: Colors.black,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
