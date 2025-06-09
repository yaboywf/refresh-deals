import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';
import '../widgets/snackbar.dart';
import '../widgets/transparent_outlinedbutton.dart';
import '../pages/register3.dart';

// ignore: must_be_immutable
class SignupPage2 extends StatelessWidget {
  FirebaseService fbService = GetIt.instance<FirebaseService>();
  final String username;
  final String uid;

  SignupPage2({super.key, this.username = '', this.uid = ''});

  void registerBuyer(BuildContext context) async {
    try {
      if (uid != '') await FirebaseFirestore.instance.collection('users').doc(uid).set({'username': username, 'accountType': 'buyer'});

      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, "/register4", (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: e.code, color: Colors.red, textColor: Colors.white));
    } catch (e) {
      debugPrint("An unknown error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (uid == '' || username == '') {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: "uid or username is empty", color: Colors.red, textColor: Colors.white));
        Navigator.pushNamedAndRemoveUntil(context, "/register", (Route<dynamic> route) => false);
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(),
      body: Background(
        padding: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
              label: Text("Back", style: TextStyle(color: Colors.black, fontSize: 17)),
            ),
            Text("Are you signing up as a business owner?", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TransparentOutlinedbutton(
                text: "Yes",
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage3(username: username, uid: uid))),
              ),
            ),
            SizedBox(width: double.infinity, child: TransparentOutlinedbutton(text: "No", onPressed: () => registerBuyer(context))),
          ],
        ),
      ),
    );
  }
}
