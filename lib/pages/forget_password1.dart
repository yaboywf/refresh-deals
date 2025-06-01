import 'package:flutter/material.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class ForgetPasswordPage1 extends StatefulWidget {
  const ForgetPasswordPage1({super.key});

  @override
  State<ForgetPasswordPage1> createState() => _ForgetPasswordPage1State();
}

class _ForgetPasswordPage1State extends State<ForgetPasswordPage1> {
  final formKey = GlobalKey<FormState>();
  String? email;

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
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(text: "Email"),
                    // Text field for the user to enter their email
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      onSaved: (value) => email = value,
                      // If the username is invalid, show an error message
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
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
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'An email has been sent to $email',
                                  style: TextStyle(color: Colors.black),
                                ),
                                duration: Duration(seconds: 2),
                                backgroundColor: Color.fromRGBO(
                                  233,
                                  218,
                                  200,
                                  1.0,
                                ),
                              ),
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              '/forget_password2',
                            );
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
