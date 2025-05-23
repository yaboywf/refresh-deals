import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController newUsernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

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
              SizedBox(height: 100),
              Center(
                child: Text(
                  "Signup",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextLabel(text: "New Username"),
              CustomTextField(
                controller: newUsernameController,
                hintText: 'Enter Username',
                obscureText: false,
              ),
              SizedBox(height: 20),
              TextLabel(text: "New Password"),
              CustomTextField(
                controller: newPasswordController,
                hintText: 'Enter Password',
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextLabel(text: "Email"),
              CustomTextField(
                controller: newPasswordController,
                hintText: 'Enter Email',
                obscureText: false,
              ),
              SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    backgroundColor: Colors.transparent,
                    minimumSize: Size(300, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed:
                      () => Navigator.pushReplacementNamed(context, '/login'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    visualDensity: VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                  child: Text(
                    "I already have an account",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
