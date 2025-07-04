import 'package:flutter/material.dart';
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
/// 5. NETS payment               (Register5) (HERE)
/// 6. Registration complete      (Register6)
///
/// For 3rd Party Registration:
/// 1. Google / Github login      (Login)
/// 2. Choosing account type      (Register3)
/// 3. Business details optional  (Register4)
/// 4. NETS payment               (Register5) (HERE)
/// 5. Registration complete      (Register6)
class SignupPage5 extends StatefulWidget {
  const SignupPage5({super.key});

  @override
  State<SignupPage5> createState() => _SignupPage5State();
}

class _SignupPage5State extends State<SignupPage5> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds
    Timer(Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/register6');
    });
  }

  @override
  void dispose() {
    super.dispose();
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
            Image.asset('images/payment.png'),
            SizedBox(height: 40),
            Text(
              "Please pay using the QR Code above to use ReFresh Deals",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
