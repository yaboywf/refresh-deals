import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/background.dart';
import '../widgets/header.dart';
import '../widgets/text_label.dart';

class SignupPage3 extends StatefulWidget {
  const SignupPage3({super.key});

  @override
  State<SignupPage3> createState() => _SignupPage3State();
}

class _SignupPage3State extends State<SignupPage3> {
  final formKey = GlobalKey<FormState>();
  String? location;
  String? businessName;

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
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLabel(text: "Business Name"),
                  // Text field for the user to enter their username
                  TextFormField(
                    cursorColor: Colors.black,
                    onSaved: (value) => businessName = value,
                    // If the username is invalid, show an error message
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your business name';
                      }
                      return null; // valid
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Enter Business Name',
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextLabel(text: "Location"),
                  // Text field for the user to enter their password
                  TextFormField(
                    cursorColor: Colors.black,
                    onSaved: (value) => location = value,
                    // If the username is invalid, show an error message
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null; // valid
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Enter Location',
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Navigator.pushReplacementNamed(context, '/register4');
                        }
                      },
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
          ],
        ),
      ),
    );
  }
}
