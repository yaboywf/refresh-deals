import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class ForgetPasswordPage2 extends StatefulWidget {
  const ForgetPasswordPage2({super.key});

  @override
  State<ForgetPasswordPage2> createState() => _ForgetPasswordPage2State();
}

class _ForgetPasswordPage2State extends State<ForgetPasswordPage2> {
  final formKey = GlobalKey<FormState>();
  String? code;

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
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(text: "Code"),
                    // Text field for the user to enter their email
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      onSaved: (value) => code = value,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      // If the username is invalid, show an error message
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a code';
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
                        hintText: 'Enter Code',
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
                            Navigator.pushReplacementNamed(
                              context,
                              '/forget_password3',
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
            ],
          ),
        ),
      ),
    );
  }
}
