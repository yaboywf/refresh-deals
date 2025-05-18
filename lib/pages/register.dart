import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController newUsernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

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
              SizedBox(height: 100,),
              Align(
                alignment: Alignment.center,
                child: Text("Signup", style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900
                )),
              ),
              SizedBox(height: 20,),
              TextLabel(text: "New Username",),
              CustomTextField(controller: newUsernameController, hintText: 'Enter Username', obscureText: false),
              SizedBox(height: 20,),
              TextLabel(text: "New Password",),
              CustomTextField(controller: newPasswordController, hintText: 'Enter Password', obscureText: true),
              SizedBox(height: 20,),
              TextLabel(text: "Email",),
              CustomTextField(controller: newPasswordController, hintText: 'Enter Email', obscureText: false),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  child: TextButton(
                    onPressed: () {}, 
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.transparent),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.black))),
                    ),
                    child: Text(
                      "Next",
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  }, 
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "I already have an account",
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