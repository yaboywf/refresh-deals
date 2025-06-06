import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import '../services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

// ignore: must_be_immutable
class SignupPage2 extends StatelessWidget {
  final String email;
  final String password;
  final String username;

  SignupPage2({
    super.key,
    this.email = '',
    this.password = '',
    this.username = '',
  });

  FirebaseService fbService = GetIt.instance<FirebaseService>();

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
                Navigator.pushReplacementNamed(context, '/register');
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
              label: Text(
                "Back",
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
              child: CustomOutlinedButton(
                text: "Yes",
                onPressed:
                    () => Navigator.pushReplacementNamed(context, "/register3"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                text: "No",
                onPressed: () async {
                  try {
                    UserCredential userCredential = await fbService.register(
                      email,
                      password,
                    );
                    User? user = userCredential.user;
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .set({'username': username, 'accountType': 'buyer'});
                    }

                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(context, '/register4');
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.code),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } catch (e) {
                    debugPrint("An unknown error occurred: $e");
                  }
                },
              ),
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

  const CustomOutlinedButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Colors.black, width: 1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        padding: EdgeInsets.all(20.0),
      ),
      child: Text(text, style: TextStyle(color: Colors.black, fontSize: 17)),
    );
  }
}
