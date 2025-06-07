import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/dropdown.dart';
import '../widgets/product_editor_card.dart';
import '../widgets/text_field.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/background.dart';
import '../widgets/text_label.dart';

final List<Map<String, dynamic>> quantityList = [
  {"expiryDate": DateTime(2025, 6, 1, 23, 59, 59), "quantity": 3, "price": 4.0},
  {"expiryDate": DateTime(2025, 6, 2, 23, 59, 59), "quantity": 2, "price": 2.0},
  {"expiryDate": DateTime(2025, 6, 3, 23, 59, 59), "quantity": 6, "price": 3.0},
];

class ShopEditorPage extends StatefulWidget {
  const ShopEditorPage({super.key});

  @override
  State<ShopEditorPage> createState() => _ShopEditorPageState();
}

class _ShopEditorPageState extends State<ShopEditorPage> {
  final ImagePicker picker = ImagePicker();
  File? image;

  // Function to pick an image
  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

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
              // Back button
              TextButton.icon(
                icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
                onPressed:
                    () => Navigator.pushReplacementNamed(
                      context,
                      '/product_listings',
                      arguments: {'accountType': 'shop'},
                    ),
                label: Text("Back", style: TextStyle(color: Colors.black)),
              ),
              // Product image
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
                        onPressed: () => pickImage(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey,
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
              // Product name
              CustomTextLabel(text: "Item Name"),
              CustomTextField(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                controller: TextEditingController(),
                hintText: 'Enter Item Name',
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              // Product price
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextLabel(text: "Item Price"),
                        Container(
                          width: double.infinity,
                          height: 55.0,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
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
                        CustomTextLabel(text: "Original Price"),
                        CustomTextField(
                          color: Color.fromRGBO(255, 255, 255, 0.6),
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
              // Product description
              CustomTextLabel(text: "Item Description"),
              CustomTextField(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                controller: TextEditingController(),
                hintText: 'Enter Item Description',
                obscureText: false,
                maxLines: 5,
              ),
              SizedBox(height: 10.0),
              // Product quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextLabel(text: "Items"),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        quantityList.add({
                          "expiryDate": DateTime(2025, 12, 31, 23, 59, 59),
                        });
                      });
                    },
                    style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              // Product quantity list
              Column(
                children: List.generate(
                  quantityList.length,
                  (index) => Column(
                    children: [
                      ProductEditorCard(
                        indexKey: index.toString(),
                        expiryDate: quantityList[index]['expiryDate'],
                        currentPrice: quantityList[index]['price'],
                        quantity: quantityList[index]['quantity'],
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
