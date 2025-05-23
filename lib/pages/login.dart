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
    return Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: 150),
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextLabel(text: "Username"),
              CustomTextField(
                controller: usernameController,
                hintText: 'Enter Username',
                obscureText: false,
              ),
              SizedBox(height: 20),
              TextLabel(text: "Password"),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter Password',
                obscureText: true,
              ),
              SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed:
                      () => Navigator.pushReplacementNamed(
                        context,
                        '/buyer_home',
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
              Align(
                alignment: Alignment.center,
                child: CustomTextButton(
                  text: "Forgotten your Password?",
                  bold: true,
                ),
              ),
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
        backgroundColor: Colors.transparent,
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
