import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../widgets/background.dart';
import '../widgets/snackbar.dart';
import '../widgets/header.dart';
import '../widgets/text_label.dart';
import '../widgets/text_form_field.dart';
import '../widgets/transparent_outlinedbutton.dart';

/// Registration Process:
/// 
/// For Local Registration:
/// 1. Enters details             (Register1) 
/// 2. Email to be verified       (Register2)
/// 3. Choosing account type      (Register3)
/// 4. Business details optional  (Register4) (HERE)
/// 5. NETS payment               (Register5)
/// 6. Registration complete      (Register6)
/// 
/// For 3rd Party Registration:
/// 1. Google / Github login      (Login)
/// 2. Choosing account type      (Register3)
/// 3. Business details optional  (Register4) (HERE)
/// 4. NETS payment               (Register5) 
/// 5. Registration complete      (Register6)

// ignore: must_be_immutable
class SignupPage4 extends StatelessWidget {
  final String username;
  final String uid;
  SignupPage4({super.key, this.username = '', this.uid = ''});

  final formKey = GlobalKey<FormState>();
  FirebaseService fbService = GetIt.instance<FirebaseService>();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();

  void registerShop(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        if (uid != '') {
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'username': username,
            'accountType': 'shop',
            'location': locationController.text,
            'businessName': businessNameController.text,
          });
        }

        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, "/register5", (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: e.code, color: Colors.red, textColor: Colors.white));
      } catch (e) {
        debugPrint("An unknown error occurred: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Text("Just a few more questions", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text field for the user to enter their business name
                  CustomTextLabel(text: "Business Name"),
                  CustomTextFormField(controller: businessNameController, hintText: 'Business Name'),
                  SizedBox(height: 20),
                  // Text field for the user to enter their location
                  CustomTextLabel(text: "Location"),
                  CustomTextFormField(controller: locationController, hintText: 'Location'),
                  SizedBox(height: 20),
                  Center(
                    child: TransparentOutlinedbutton(
                      onPressed: () => registerShop(context),
                      text: "Create",
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
