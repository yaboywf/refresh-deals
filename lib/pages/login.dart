import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/text_label.dart';
import '../widgets/text_form_field.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';
import '../widgets/snackbar.dart';
import '../widgets/transparent_textbutton.dart';
import '../widgets/transparent_outlinedbutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  FirebaseService fbService = GetIt.instance<FirebaseService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      UserCredential userCredential = await fbService.login(email, password);
      User? user = userCredential.user;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
      if (userDoc.exists) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: 'Hello, ${userDoc['username']} ($email)!'));
        Navigator.pushReplacementNamed(context, "/${userDoc['accountType']}_home");
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: e.code, color: Colors.red, textColor: Colors.white,));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold that contains the login page
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(),
      body: Background(
        padding: 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered text that says "Login"
            Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextLabel(text: "Email"),
                  // Text field for the user to enter their email
                  CustomTextFormField(controller: emailController, inputType: TextInputType.emailAddress, hintText: 'Email'),
                  SizedBox(height: 20),
                  // Text field for the user to enter their password
                  CustomTextLabel(text: "Password"),
                  CustomTextFormField(controller: passwordController, obscureText: true, hintText: 'Password'),
                  SizedBox(height: 20),
                  // Centered button that says "Login"
                  Center(
                    child: TransparentOutlinedbutton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          login(context);
                        }
                      },
                      text: "Login"
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Button for forget password
            CustomTextButton(
              text: "Forgotten your Password?",
              bold: true,
              onPressed: () => Navigator.pushReplacementNamed(context, '/forget_password1'),
            ),
            // Button for registration
            CustomTextButton(text: "New to Refresh Deals? Create an account!", onPressed: () => Navigator.pushReplacementNamed(context, '/register')),
          ],
        ),
      ),
    );
  }
}