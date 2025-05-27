import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class ForgetPasswordPage2 extends StatelessWidget {
  ForgetPasswordPage2({super.key});
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
                  "An email was sent to you",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextLabel(text: "Code"),
              // Text field for the user to enter their email
              CustomTextField(
                controller: emailController,
                hintText: 'Enter Code',
                obscureText: false,
              ),
              SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed:
                      () => Navigator.pushReplacementNamed(context, '/forget_password3'), 
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
            ],
          ),
        ),
      ),
    );
  }
}