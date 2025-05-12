import 'package:flutter/material.dart';
import '../widgets/text_field.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'images/logo.png', 
                  width: 400, 
                  height: 50,
                  fit: BoxFit.contain
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900
                  )),
                ],
              ),
              SubHeading(text: "Username",),
              MyTextField(controller: usernameController, hintText: 'Enter Email', obscureText: false),
              SizedBox(height: 20,),
              SubHeading(text: "Password",),
              MyTextField(controller: passwordController, hintText: 'Enter Password', obscureText: true),
              TextButton(
                onPressed: () {}, 
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white)
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}

class SubHeading extends StatelessWidget {
  final String text;
  const SubHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold
      ),
    );
  }
}