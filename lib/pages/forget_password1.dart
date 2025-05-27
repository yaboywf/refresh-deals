import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class ForgetPasswordPage1 extends StatelessWidget {
  ForgetPasswordPage1({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Center(
                child: Text(
                  "Forget Password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextLabel(text: "Email"),
              // Text field for the user to enter their email
              CustomTextField(
                controller: emailController,
                hintText: 'Enter Email',
                obscureText: false,
              ),
              SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed:
                      () => Navigator.pushReplacementNamed(context, '/forget_password2'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(300, 30),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    // Make the button transparent
                    backgroundColor: Colors.transparent,
                    // Make the button as small as possible.
                    visualDensity: VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                  onPressed:
                      () => Navigator.pushReplacementNamed(context, '/login'),
                  child: Text(
                    "I Remember My Password Now",
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