import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/widgets/dropdown.dart';
import 'package:project/widgets/text_field.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/background.dart';
import '../widgets/text_label.dart';

class ShopEditorPage extends StatelessWidget {
  const ShopEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(accountType: 'shop', currentIndex: 1),
      body: Background(
        padding: 20.0,
        imagePath: 'images/content_bg.jpg',
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
                onPressed:
                    () => Navigator.pushReplacementNamed(context, '/shop_home'),
                label: Text("Back", style: TextStyle(color: Colors.black)),
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage("images/bread.webp"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15.0),
                          alignment: Alignment.center,
                          visualDensity: VisualDensity.compact,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.penToSquare,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              TextLabel(text: "Item Name"),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Enter Item Name',
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel(text: "Item Price"),
                        Container(
                          width: double.infinity,
                          height: 55.0,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Dropdown(), 
                        ), 
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0), 
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel(text: "Original Price"),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: 'Enter Original Price',
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              TextLabel(text: "Item Description"),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'Enter Item Description',
                obscureText: false,
                maxLines: 5,
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextLabel(text: "Items"),
                  FaIcon(FontAwesomeIcons.plus, color: Colors.black, size: 18),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
