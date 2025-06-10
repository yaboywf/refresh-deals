import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import '../services/firebase_service.dart';
import '../widgets/transparent_outlinedbutton.dart';
import '../widgets/background.dart';
import '../widgets/header.dart';
import '../widgets/snackbar.dart';
import 'register3.dart';

/// Registration Process:
///
/// For Local Registration:
/// 1. Enters details             (Register1)
/// 2. Email to be verified       (Register2) (HERE)
/// 3. Choosing account type      (Register3)
/// 4. Business details optional  (Register4)
/// 5. NETS payment               (Register5)
/// 6. Registration complete      (Register6)
///
/// For 3rd Party Registration:
/// 1. Google / Github login      (Login)
/// 2. Choosing account type      (Register3)
/// 3. Business details optional  (Register4)
/// 4. NETS payment               (Register5)
/// 5. Registration complete      (Register6)
class SignupPage2 extends StatefulWidget {
  final String username;
  final String uid;
  const SignupPage2({super.key, this.username = '', this.uid = ''});

  @override
  State<SignupPage2> createState() => _SignupPage2();
}

class _SignupPage2 extends State<SignupPage2> {
  bool isEmailVerified = false;
  final FirebaseService fbService = GetIt.instance.get<FirebaseService>();

  @override
  void initState() {
    super.initState();
    fbService.sendEmailVerification();
    checkEmailVerification(context);
  }

  // Function to check if the email is verified
  Future<void> checkEmailVerification(BuildContext context) async {
    User? user = fbService.getCurrentUser();
    
    if (user != null) {
      Timer.periodic(Duration(seconds: 2), (timer) async {
        bool isVerified = await checkEmailVerified();

        if (isVerified) { 
          timer.cancel();
          setState(() => isEmailVerified = true);
          if (!context.mounted) return;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage3(username: widget.username, uid: widget.uid)));
        }
      });
    }

    return Future.value(); 
  }

  Future<bool> checkEmailVerified() async {
    User user = fbService.getCurrentUser()!;
    await user.reload();
    return user.emailVerified;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.uid == '' || widget.username == '') {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: "uid or username is empty", color: Colors.red, textColor: Colors.white));
        Navigator.pushNamedAndRemoveUntil(context, "/register", (Route<dynamic> route) => false);
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(),
      body: Background(
        padding: 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please verify your email to continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            isEmailVerified ? Text("Email Verified! Redirecting...") : CircularProgressIndicator(color: Colors.black),
            SizedBox(height: 20),
            TransparentOutlinedbutton(onPressed: () => fbService.sendEmailVerification(), text: 'Resend Email', minimumSize: Size(150, 40),),
          ],
        ),
      ),
    );
  }
}
