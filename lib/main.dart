import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/buyer_home.dart';
import 'pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Refresh Deals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => SignupPage(),
        '/buyer_home': (context) => BuyerHomepage(),
        '/profile': (context) => Profile(),
      },
    );
  }
}