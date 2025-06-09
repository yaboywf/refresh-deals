import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../pages/register2.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';
import '../widgets/text_form_field.dart';
import '../widgets/transparent_textbutton.dart';
import '../widgets/transparent_outlinedbutton.dart';
import '../widgets/snackbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseService fbService = GetIt.instance<FirebaseService>();
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

  void submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        UserCredential userCredential = await fbService.register(emailController.text, passwordController.text);
        User? user = userCredential.user;

        if (user == null) {
          debugPrint("Registration failed: user is null.");
          return;
        }

        if (!context.mounted) return;
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage2(username: usernameController.text, uid: user.uid)));
      } on FirebaseAuthException catch (e) {
        
        String message;

        switch (e.code) {
          case 'email-already-in-use':
            {
              message = 'This email is already registered. Please login.';
              break;
            }
          case 'invalid-email':
            {
              message = 'This is an invalid email. Please try again.';
              break;
            }
          case 'weak-password':
            {
              message = 'Your password is too weak. Please try again.';
              break;
            }
          default:
            {
              message = e.code;
              break;
            }
        }

        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: message, color: Colors.red, textColor: Colors.white));
      } catch (e) {
        debugPrint("An unknown error occurred: $e");
      }
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
                  Center(child: TransparentOutlinedbutton(onPressed: () => submit(context), text: "Next")),
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
