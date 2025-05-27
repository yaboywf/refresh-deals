import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/background.dart';
import '../widgets/header.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';

class SignupPage3 extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();

  SignupPage3({super.key});

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
                Navigator.pushReplacementNamed(context, '/register2');
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
              label: Text(
                "Back",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            Text(
              "Just a few more questions",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextLabel(text: "Business Name"),
            // Text field for the user to enter their username
            CustomTextField(
              controller: businessNameController,
              hintText: 'Enter Business Name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            TextLabel(text: "Location"),
            // Text field for the user to enter their password
            CustomTextField(
              controller: locationController,
              hintText: 'Enter Location',
              obscureText: true,
              maxLines: 1,
            ),
            SizedBox(height: 20),
            Center(
                child: OutlinedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/register4'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(300, 30),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Create",
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
    );
  }
}
