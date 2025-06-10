import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import '../widgets/background.dart';
import '../widgets/header.dart';

/// Registration Process:
///
/// For Local Registration:
/// 1. Enters details             (Register1)
/// 2. Email to be verified       (Register2)
/// 3. Choosing account type      (Register3)
/// 4. Business details optional  (Register4)
/// 5. NETS payment               (Register5)
/// 6. Registration complete      (Register6) (HERE)
///
/// For 3rd Party Registration:
/// 1. Google / Github login      (Login)
/// 2. Choosing account type      (Register3)
/// 3. Business details optional  (Register4)
/// 4. NETS payment               (Register5)
/// 5. Registration complete      (Register6) (HERE)
class SignupPage6 extends StatefulWidget {
  const SignupPage6({super.key});

  @override
  State<SignupPage6> createState() => _SignupPage6State();
}

class _SignupPage6State extends State<SignupPage6> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds
    Timer(Duration(seconds: 3), () {
      if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
    });
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
            FaIcon(FontAwesomeIcons.check, color: Colors.black, size: 80),
            SizedBox(height: 10),
            Text("Account Created", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
