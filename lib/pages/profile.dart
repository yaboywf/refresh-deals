import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';
import '../widgets/snackbar.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  // The type of account to show.
  String accountType;
  ProfilePage({super.key, this.accountType = 'buyer'});
  FirebaseService fbService = GetIt.instance<FirebaseService>();

  // The text controllers for the fields.
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Fetches some data (with a delay) and returns a string.
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return "Data has been fetched!";
  }

  // Fetches some data (with a delay) and returns a string, but throws an exception.
  Future<String> fetchDataWithError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ac feugiat augue, quis aliquet orci. Praesent in purus et turpis dictum tincidunt vel fermentum nisl. Nullam in est commodo risus suscipit blandit nec ut nunc. Proin eu erat quis ligula suscipit venenatis. Phasellus ullamcorper metus sed erat mollis, vehicula rutrum.',
    );
  }

  // Shows a dialog when user attempts to logout
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(233, 218, 200, 1.0),
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(child: Text("Cancel", style: TextStyle(color: Colors.black)), onPressed: () => Navigator.of(context).pop()),
            TextButton(
              child: Text("Logout", style: TextStyle(color: Colors.black)),
              onPressed: () async {
                try {
                  await fbService.logout();
                  if (!context.mounted) return;
                  CustomSnackBar(text: "Logout successfully");
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: e.code, color: Colors.red, textColor: Colors.white));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen.
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // If the account type is not specified, use the one passed in the arguments.
    if (arguments != null && arguments.containsKey('accountType')) accountType = arguments['accountType']!;

    return Scaffold(
      bottomNavigationBar: NavBar(accountType: accountType, currentIndex: 2),
      body: Background(
        padding: 20.0,
        // The future to fetch the data.
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            // If the future is still waiting, show a loading indicator.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Header(hasPadding: false,),
                  SizedBox(height: 80),
                  CircularProgressIndicator(color: Colors.black),
                  SizedBox(height: 15),
                  Text("Loading...", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              );
            } else if (snapshot.hasError) {
              // If the future has an error, show an error message.
              return Column(
                children: [
                  Header(hasPadding: false,),
                  SizedBox(height: 80),
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 15),
                  Text("An Error Occurred!", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  Text(snapshot.error.toString(), maxLines: 10, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 18)),
                ],
              );
            } else {
              // If the future has data, show the form.
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(hasPadding: false,),
                    Text("General", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                    SizedBox(height: 20),
                    CustomTextLabel(text: "Username"),
                    CustomTextField(controller: nameController, hintText: "Enter Username", obscureText: false),
                    SizedBox(height: 20),
                    CustomTextLabel(text: "Email"),
                    CustomTextField(controller: emailController, hintText: "Enter Email", obscureText: false),
                    if (accountType == 'shop') ...[
                      SizedBox(height: 20),
                      CustomTextLabel(text: "Business Name"),
                      CustomTextField(controller: storeNameController, hintText: "Enter Business Name", obscureText: false),
                      SizedBox(height: 20),
                      CustomTextLabel(text: "Location"),
                      CustomTextField(controller: addressController, hintText: "Enter Store Location", obscureText: false),
                    ],
                    Align(alignment: Alignment.centerRight, child: BorderButton(text: "Save")),
                    SizedBox(height: 30),
                    Text("Change Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                    SizedBox(height: 20),
                    CustomTextLabel(text: "New Password"),
                    CustomTextField(controller: passwordController, hintText: "Enter Password", obscureText: false),
                    SizedBox(height: 20),
                    CustomTextLabel(text: "Re-enter Password"),
                    CustomTextField(controller: confirmPasswordController, hintText: "Enter Password", obscureText: false),
                    Align(alignment: Alignment.centerRight, child: BorderButton(text: "Change")),
                    Center(child: BorderButton(text: "Logout", onPressed: () => showLogoutDialog(context))),
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

/// A custom button that is styled to have a border around it.
/// The [text] parameter is the text that will be displayed on the button.
/// The [onPressed] parameter is an optional callback that will be called
/// when the button is pressed.
class BorderButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const BorderButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      /// The callback that will be called when the button is pressed.
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        /// The minimum size for the button.
        minimumSize: Size(80, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: Colors.black),
        padding: EdgeInsets.all(3.0),
      ),
      child: Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
