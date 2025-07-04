import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '../services/firebase_service.dart';

import 'pages/forget_password1.dart';
import 'pages/forget_password2.dart';
import 'pages/login.dart';
import 'pages/register1.dart';
import 'pages/register2.dart';
import 'pages/register3.dart';
import 'pages/register4.dart';
import 'pages/register5.dart';
import 'pages/register6.dart';

import 'pages/buyer_home.dart';
import 'pages/product_listings.dart';
import 'pages/profile.dart';
import 'pages/buyer_product.dart';

import 'pages/shop_home.dart';
import 'pages/shop_editor.dart';

import '../widgets/background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetIt.instance.registerLazySingleton(() => FirebaseService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseService fbService = GetIt.instance<FirebaseService>();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReFresh Deals',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: FutureBuilder(
        future: fbService.getUserInformation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Background(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.black),
                    SizedBox(height: 20),
                    Text('Loading, please wait...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
          }

          if (snapshot.data == null) return LoginPage();

          return snapshot.data['accountType'] == 'buyer' ? BuyerHomepage() : ShopHomePage(); 
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => SignupPage(),
        '/register2': (context) => SignupPage2(),
        '/register3': (context) => SignupPage3(),
        '/register4': (context) => SignupPage4(),
        '/register5': (context) => SignupPage5(),
        '/register6': (context) => SignupPage6(),
        '/forget_password1': (context) => ForgetPasswordPage1(),
        '/forget_password2': (context) => ForgetPasswordPage2(),
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
