import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/product_details_card.dart';
import '../widgets/dropdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class BuyerShopPage extends StatelessWidget {
  BuyerShopPage({super.key});

  final TextEditingController searchController = TextEditingController();
  final TextEditingController priceStartController = TextEditingController();
  final TextEditingController priceEndController = TextEditingController();

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
      "storeName": "Store C",
      "address": "789 Pine Street",
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
    return Scaffold(
      bottomNavigationBar: NavBar(accountType: 'buyer', currentIndex: 1),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/content_bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(255, 255, 255, 1.0),
              BlendMode.softLight,
            ),
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  SizedBox(width: 10.0),
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
                  child: Dropdown(),
                ),
                SizedBox(width: 10.0),
                Row(
                  children: [
                    Text('\$', style: TextStyle(fontSize: 16.0)),
                    SizedBox(width: 5.0),
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
                      children: [ProductDetailsCard(product: productList[index]), SizedBox(height: 10.0)],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
