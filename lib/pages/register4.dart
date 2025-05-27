import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/background.dart';
import '../widgets/header.dart';

class SignupPage4 extends StatelessWidget {
  const SignupPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        padding: 20.0,
        child: Column(
          children: [
            Header(),
            Center(
              child: Column(
                children: [
                  FaIcon(FontAwesomeIcons.check, color: Colors.black, size: 35,),
                  Text("Account Created", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}