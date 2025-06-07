import 'package:flutter/material.dart';
import 'package:project/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';
import '../widgets/text_form_field.dart';
import '../widgets/transparent_textbutton.dart';
import '../widgets/transparent_outlinedbutton.dart';
import '../services/firebase_service.dart';

class ForgetPasswordPage1 extends StatefulWidget {
  const ForgetPasswordPage1({super.key});

  @override
  State<ForgetPasswordPage1> createState() => _ForgetPasswordPage1State();
}

class _ForgetPasswordPage1State extends State<ForgetPasswordPage1> {
  FirebaseService fbService = GetIt.instance<FirebaseService>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        formKey.currentState!.save();
        await fbService.forgetPassword(emailController.text);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: 'An email has been sent to ${emailController.text}'));
        Navigator.pushReplacementNamed(context, '/forget_password2');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: e.code, color: Colors.red, textColor: Colors.white));
      }
    }
  }

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
            Text("Forget Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text field for the user to enter their email
                  CustomTextLabel(text: "Email"),
                  CustomTextFormField(controller: emailController, inputType: TextInputType.emailAddress, hintText: 'Email'),
                  SizedBox(height: 20),
                  Center(child: TransparentOutlinedbutton(onPressed: () => submit(context), text: "Next")),
                ],
              ),
            ),
            CustomTextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), text: "I Remember My Password Now"),
          ],
        ),
      ),
    );
  }
}
