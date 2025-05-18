import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/authentication_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: 150,),
              Align(
                alignment: Alignment.center,
                child: Text("Login", style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900
                )),
              ),
              SizedBox(height: 20,),
              TextLabel(text: "Username",),
              CustomTextField(controller: usernameController, hintText: 'Enter Username', obscureText: false),
              SizedBox(height: 20,),
              TextLabel(text: "Password",),
              CustomTextField(controller: passwordController, hintText: 'Enter Password', obscureText: true),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/buyer_home');
                    }, 
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.transparent),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.black))),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {}, 
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "Forgotten Your Password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  }, 
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "New to Refresh Deals? Create an account!",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}