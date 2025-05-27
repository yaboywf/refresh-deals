import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class SignupPage2 extends StatelessWidget {
  const SignupPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        imagePath: "images/authentication_bg.jpg",
        padding: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
              label: Text(
                "Back to Login",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            Text(
              "Are you signing up as a business owner?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(text: "Yes", onPressed: () => Navigator.pushReplacementNamed(context, "/register3")),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(text: "No"),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) { 
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.black, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        padding: EdgeInsets.all(20.0)
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
    );
  }
}
