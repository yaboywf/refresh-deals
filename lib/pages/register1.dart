import 'package:flutter/material.dart';
import '../pages/register2.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';
import '../widgets/text_form_field.dart';
import '../widgets/transparent_textbutton.dart';
import '../widgets/transparent_outlinedbutton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupPage2(email: emailController.text, password: passwordController.text, username: usernameController.text),
        ),
      );
    }
  }

  // This page is used to register a new user.
  // It takes in a new username, new password, and an email address.
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
            Text("Signup", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text field for the user to enter their username
                  CustomTextLabel(text: "New Username"),
                  CustomTextFormField(controller: usernameController, hintText: "Username"),
                  SizedBox(height: 20),
                  // Text field for the user to enter their password
                  CustomTextLabel(text: "New Password"),
                  CustomTextFormField(controller: passwordController, obscureText: true, hintText: "Password"),
                  SizedBox(height: 20),
                  // Text field for the user to enter their email
                  CustomTextLabel(text: "Email"),
                  CustomTextFormField(controller: emailController, inputType: TextInputType.emailAddress, hintText: "Email"),
                  SizedBox(height: 20),
                  Center(
                    child: TransparentOutlinedbutton(
                      onPressed: submit,
                      text: "Next",
                    ),
                  ),
                ],
              ),
            ),
            CustomTextButton(text: "I already have an account", onPressed: () => Navigator.pushReplacementNamed(context, '/login')),
          ],
        ),
      ),
    );
  }
}