import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/text_field.dart';
import '../widgets/text_label.dart';
import '../widgets/header.dart';
import '../widgets/background.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  /// The type of account to show.
  String accountType;
  ProfilePage({super.key, this.accountType = 'buyer'});

  /// Fetches some data (with a delay) and returns a string.
  ///
  /// This is just a placeholder for some actual data fetching.
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return "Data has been fetched!";
  }

  /// Fetches some data (with a delay) and returns a string, but throws an exception.
  ///
  /// This is just a placeholder for some actual data fetching.
  Future<String> fetchDataWithError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ac feugiat augue, quis aliquet orci. Praesent in purus et turpis dictum tincidunt vel fermentum nisl. Nullam in est commodo risus suscipit blandit nec ut nunc. Proin eu erat quis ligula suscipit venenatis. Phasellus ullamcorper metus sed erat mollis, vehicula rutrum.',
    );
  }

  /// The text controllers for the fields.
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
    /// Get the arguments passed from the previous screen.
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    /// If the account type is not specified, use the one passed in the arguments.
    if (arguments != null && arguments.containsKey('accountType')) {
      accountType = arguments['accountType']!;
    }

    return Scaffold(
      /// The navigation bar at the bottom.
      bottomNavigationBar: NavBar(accountType: accountType, currentIndex: 2),
      body: Background(
        /// The background image.
        imagePath: 'images/authentication_bg.jpg',
        padding: 20.0,
        child: FutureBuilder<String>(
          /// The future to fetch the data.
          future: fetchData(),
          builder: (context, snapshot) {
            /// If the future is still waiting, show a loading indicator.
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
              /// If the future has an error, show an error message.
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
              /// If the future has data, show the form.
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
                      child: BorderButton(text: "Save"),
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
                      child: BorderButton(text: "Change"),
                    ),
                    Center(
                      child: BorderButton(
                        text: "Logout",
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Logged out successfully!',
                                style: TextStyle(color: Colors.black),
                              ),
                              duration: Duration(seconds: 2),
                              backgroundColor: Color.fromRGBO(
                                233,
                                218,
                                200,
                                1.0,
                              ),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                      ),
                    ),
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

      /// The style for the button.
      style: OutlinedButton.styleFrom(
        /// The minimum size for the button.
        minimumSize: Size(80, 0),

        /// The shape of the button.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        /// The border of the button.
        side: BorderSide(color: Colors.black),

        /// The padding for the button.
        padding: EdgeInsets.all(3.0),
      ),

      /// The text that will be displayed on the button.
      child: Text(
        text,

        /// The style for the text.
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
