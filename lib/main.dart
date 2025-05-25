import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';

import 'pages/buyer_home.dart';
import 'pages/product_listings.dart';
import 'pages/profile.dart';
import 'pages/buyer_product.dart';

import 'pages/shop_home.dart';
import 'pages/shop_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
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
        '/buyer_product': (context) => BuyerProductPage(),
        '/buyer_home': (context) => BuyerHomepage(),
        '/product_listings': (context) => ProductListingPage(),
        '/profile': (context) => ProfilePage(),
        '/shop_home': (context) => ShopHomePage(),
        '/shop_editor': (context) => ShopEditorPage(),
      },
    );
  }
}
