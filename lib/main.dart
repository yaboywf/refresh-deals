import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';

import 'pages/buyer_home.dart';
import 'pages/buyer_shop.dart';
import 'pages/profile.dart';
import 'pages/buyer_product.dart';

import 'pages/shop_home.dart';

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
      home: ShopHomePage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => SignupPage(),
        '/buyer_product': (context) => BuyerProductPage(),
        '/buyer_home': (context) => BuyerHomepage(),
        '/buyer_shop': (context) => BuyerShopPage(),
        '/profile': (context) => Profile(),
        '/shop_home': (context) => ShopHomePage(),
      },
    );
  }
}