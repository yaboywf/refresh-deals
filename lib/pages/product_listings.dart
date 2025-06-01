import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/product_details_card.dart';
import '../widgets/dropdown.dart';
import '../widgets/background.dart';

// ignore: must_be_immutable
class ProductListingPage extends StatelessWidget {
  /// the type of account currently being used
  String accountType;
  ProductListingPage({super.key, this.accountType = 'buyer'});

  /// the controller for the search bar
  final TextEditingController searchController = TextEditingController();
  /// the controller for the start price text field
  final TextEditingController priceStartController = TextEditingController();
  /// the controller for the end price text field
  final TextEditingController priceEndController = TextEditingController();

  /// sample list of products to display
  static const List<Map<String, dynamic>> productList = [
    {
      "image": "images/product1.jpg",
      "name": "Product 1",
      "category": "Category 1",
      "minPrice": 3.00,
      "maxPrice": 5.00,
      "maxDiscount": "20",
      "expiringQuantity": 2,
      "totalQuantity": 10,
      "storeName": "Store A",
      "address": "123 Maple Street",
    },
    {
      "image": "images/product2.jpg",
      "name": "Product 2",
      "category": "Category 2",
      "minPrice": 5.00,
      "maxPrice": 10.00,
      "maxDiscount": "30",
      "expiringQuantity": 1,
      "totalQuantity": 5,
      "storeName": "Store B",
      "address": "456 Oak Street",
    },
    {
      "image": "images/product3.jpg",
      "name": "Bread",
      "category": "Category 3",
      "minPrice": 10.00,
      "maxPrice": 20.00,
      "maxDiscount": "40",
      "expiringQuantity": 3,
      "totalQuantity": 3,
      "storeName": "Temasek Polytechnic",
      "address": "21 Tampines Ave 1, Singapore 529757",
    },
    {
      "image": "images/product4.jpg",
      "name": "Product 4",
      "category": "Category 4",
      "minPrice": 20.00,
      "maxPrice": 30.00,
      "maxDiscount": "50",
      "expiringQuantity": 2,
      "totalQuantity": 2,
      "storeName": "Store D",
      "address": "101 Cedar Street",
    },
    {
      "image": "images/product5.jpg",
      "name": "Product 5",
      "category": "Category 5",
      "minPrice": 30.00,
      "maxPrice": 40.00,
      "maxDiscount": "60",
      "expiringQuantity": 1,
      "totalQuantity": 1,
      "storeName": "Store E",
      "address": "202 Birch Street",
    }
  ];

  @override
  Widget build(BuildContext context) {
    /// if the account type is provided in the route arguments, use it
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    if (arguments != null && arguments.containsKey('accountType')) {
      accountType = arguments['accountType']!;
    }

    return Scaffold(
      /// the bottom navigation bar
      bottomNavigationBar: NavBar(accountType: accountType, currentIndex: 1),
      /// the body of the page
      body: Background(
        imagePath: 'images/content_bg.jpg',
        padding: 20.0,
        child: Column(
          children: [
            Container(
              /// add a bottom border to the search bar
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                children: [
                  /// the search bar icon
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  SizedBox(width: 10.0),
                  /// the search bar text field
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Search an item',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  /// the dropdown menu for category
                  child: Dropdown(),
                ),
                SizedBox(width: 10.0),
                Row(
                  children: [
                    Text('\$', style: TextStyle(fontSize: 16.0)),
                    SizedBox(width: 5.0),
                    /// the start price text field
                    SizedBox(
                      width: 50.0,
                      child: TextField(
                        controller: priceStartController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text('to \$', style: TextStyle(fontSize: 16.0)),
                    SizedBox(width: 5.0),
                    /// the end price text field
                    SizedBox(
                      width: 50.0,
                      child: TextField(
                        controller: priceEndController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder:
                    (context, index) => Column(
                      children: [ProductDetailsCard(key: Key(index.toString()), accountType: accountType, product: productList[index]), SizedBox(height: 10.0)],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
