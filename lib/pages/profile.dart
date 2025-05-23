import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

class Profile extends StatelessWidget {
  String accountType;
  Profile({super.key, this.accountType = 'buyer'});

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return "Data has been fetched!";
  }

  Future<String> fetchDataWithError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ac feugiat augue, quis aliquet orci. Praesent in purus et turpis dictum tincidunt vel fermentum nisl. Nullam in est commodo risus suscipit blandit nec ut nunc. Proin eu erat quis ligula suscipit venenatis. Phasellus ullamcorper metus sed erat mollis, vehicula rutrum.',
    );
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    if (arguments != null && arguments.containsKey('accountType')) {
      accountType = arguments['accountType']!;
    }

    return Scaffold(
      bottomNavigationBar: NavBar(accountType: accountType, currentIndex: 2),
      body: Background(
        imagePath: 'images/authentication_bg.jpg',
        padding: 20.0,
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Header(),
                  SizedBox(height: 100),
                  CircularProgressIndicator(color: Colors.black),
                  SizedBox(height: 15),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  Header(),
                  SizedBox(height: 70),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(100),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 50),
                        SizedBox(height: 15),
                        Text(
                          "An Error Occurred!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          snapshot.error.toString(),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(),
                    Text(
                      "General",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextLabel(text: "Username"),
                    CustomTextField(
                      controller: nameController,
                      hintText: "Enter Username",
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    TextLabel(text: "Email"),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Enter Email",
                      obscureText: false,
                    ),
                    if (accountType == 'shop') ...[
                      SizedBox(height: 20),
                      TextLabel(text: "Business Name"),
                      CustomTextField(
                        controller: storeNameController,
                        hintText: "Enter Business Name",
                        obscureText: false,
                      ),
                      SizedBox(height: 20),
                      TextLabel(text: "Location"),
                      CustomTextField(
                        controller: addressController,
                        hintText: "Enter Store Location",
                        obscureText: false,
                      ),
                    ],
                    Align(
                      alignment: Alignment.centerRight,
                      child: BorderButton(text: "Save",),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextLabel(text: "New Password"),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Enter Password",
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    TextLabel(text: "Re-enter Password"),
                    CustomTextField(
                      controller: confirmPasswordController,
                      hintText: "Enter Password",
                      obscureText: false,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BorderButton(text: "Change",),
                    ),
                    Center(
                      child: BorderButton(text: "Logout", onPressed: () => Navigator.pushReplacementNamed(context, "/login"),),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const BorderButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(80, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: Colors.black),
        padding: EdgeInsets.all(3.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
