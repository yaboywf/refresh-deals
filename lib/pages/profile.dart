import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/text_field.dart';
import '../widgets/text_form_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/transparent_outlinedbutton.dart';
import '../widgets/background.dart';
import '../widgets/snackbar.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  // The type of account to show.
  String accountType;
  ProfilePage({super.key, this.accountType = 'buyer'});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();

  // The text controllers for the fields.
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String provider = '';

  final changePasswordFormKey = GlobalKey<FormState>();
  final generalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Fetch user information when the page loads
    fetchUserInfo(context);
  }

  void fetchUserInfo(BuildContext context) async {
    try {
      var userInfo = await fbService.getUserInformation();
      if (userInfo != null) {
        setState(() {
          // Set the controllers' text to the fetched values
          nameController.text = userInfo['username'] ?? '';
          provider = fbService.getCurrentUser()?.providerData[0].providerId ?? '';
          emailController.text = fbService.getCurrentUser()?.providerData[0].email ?? '';
          if (widget.accountType == 'shop') {
            storeNameController.text = userInfo['businessName'] ?? '';
            addressController.text = userInfo['location'] ?? '';
          }
        });
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(CustomSnackBar(text: 'Error while fetching user information', color: Colors.red, textColor: Colors.white));
      debugPrint('Error fetching user info: $e');
    }
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
    if (arguments != null && arguments.containsKey('accountType')) widget.accountType = arguments['accountType']!;

    if (fbService.getCurrentUser() == null) {
      Future.microtask(() {
        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
      });
      return SizedBox();
    }

    return Scaffold(
      bottomNavigationBar: NavBar(accountType: widget.accountType, currentIndex: 2),
      body: Background(
        padding: 20.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(hasPadding: false),
              Text("General", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              SizedBox(height: 20),
              Form(
                key: generalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextLabel(text: "Username"),
                    CustomTextFormField(controller: nameController, hintText: "Enter Username"),
                    SizedBox(height: 20),
                    CustomTextLabel(text: "Email"),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Email",
                      enabled: !(provider == 'google.com' || provider == 'github.com'),
                      inputType: TextInputType.emailAddress,
                    ),
                    if (provider == 'google.com' || provider == 'github.com') ...[
                      SizedBox(height: 5),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.red, size: 12.0),
                          SizedBox(width: 5),
                          Text(
                            "Email can't be changed (${provider.split('.')[0][0].toUpperCase() + provider.split('.')[0].substring(1)} Login)",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                    if (widget.accountType == 'shop') ...[
                      SizedBox(height: 20),
                      CustomTextLabel(text: "Business Name"),
                      CustomTextField(controller: storeNameController, hintText: "Enter Business Name", obscureText: false),
                      SizedBox(height: 20),
                      CustomTextLabel(text: "Location"),
                      CustomTextField(controller: addressController, hintText: "Enter Store Location", obscureText: false),
                    ],
                    Align(
                      alignment: Alignment.centerRight,
                      child: TransparentOutlinedbutton(
                        text: "Save",
                        onPressed: () {
                          if (generalFormKey.currentState!.validate()) {
                            fbService.updateUsername(context, nameController.text);
                          }
                        },
                        minimumSize: Size(90, 25),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Text("Change Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              SizedBox(height: 20),
              Form(
                key: changePasswordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text field for the user to enter their new password
                    CustomTextLabel(text: "New Password"),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      enabled: !(provider == 'google.com' || provider == 'github.com'),
                    ),
                    SizedBox(height: 20),

                    // Text field for the user to re-enter their new password
                    CustomTextLabel(text: "Re-enter Password"),
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      hintText: "Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your password';
                        if (value != passwordController.text) return "Passwords do not match";
                        return null;
                      },
                      enabled: !(provider == 'google.com' || provider == 'github.com'),
                    ),
                    if (provider != 'google.com' && provider != 'github.com') ...[
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TransparentOutlinedbutton(
                          text: "Change",
                          onPressed: () {
                            if (changePasswordFormKey.currentState!.validate()) {
                              changePasswordFormKey.currentState!.save();
                              fbService.updatePassword(context, passwordController.text);
                            }
                          },
                          minimumSize: Size(90, 25),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 5),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.red, size: 12.0),
                          SizedBox(width: 5),
                          Text(
                            "Password can't be changed (${provider.split('.')[0][0].toUpperCase() + provider.split('.')[0].substring(1)} Login)",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ],
                ),
              ),

              Center(child: TransparentOutlinedbutton(text: "Logout", onPressed: () => showLogoutDialog(context), minimumSize: Size(90, 30))),
            ],
          ),
        ),
      ),
    );
  }
}
