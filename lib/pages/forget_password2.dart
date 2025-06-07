import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';
import '../widgets/transparent_outlinedbutton.dart';

class ForgetPasswordPage2 extends StatelessWidget {
  const ForgetPasswordPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(),
      body: Background(
        padding: 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email, size: 100, color: Colors.black),
            SizedBox(height: 20),
            Text(
              "An email was sent to you with a link to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TransparentOutlinedbutton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false),
              text: "Back to Login",
            ),
          ],
        ),
      ),
    );
  }
}
