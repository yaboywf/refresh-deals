import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/product_quantity_card.dart';
import '../widgets/background.dart';

// ignore: must_be_immutable
class BuyerProductPage extends StatefulWidget {
  // The name of the product being viewed
  String productName;

  // Constructor for BuyerProductPage, initializes with an optional productName
  BuyerProductPage({super.key, this.productName = ''});

  @override
  // Creates the mutable state for this widget
  State<BuyerProductPage> createState() => _BuyerProductState();
}

// This page displays details about a selected product such as its name, description, price
// Provides related recipes that can be made with the product.
class _BuyerProductState extends State<BuyerProductPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // If the user navigated to this page from the product listing page, they
    // will pass the name of the product they want to view.
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null &&
        args is Map<String, dynamic> &&
        args.containsKey('productName')) {
      setState(() {
        widget.productName = args['productName'];
      });
    }

    // Fetch the related recipes for the selected product.
    fetchRelatedRecipies();
  }

  // Fetches the related recipes for the selected product
  Future<List<Map<String, String>>> fetchRelatedRecipies() async {
    final url = 'https://www.themealdb.com/api/json/v1/1/search.php';
    final response = await http.get(Uri.parse('$url?s=${widget.productName}'));

    if (response.statusCode == 200) {
      // Unwrap the JSON data and get the list of recipes
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> meals = data['meals'] ?? [];
      List<Map<String, String>> mealDetails =
          meals.map((meal) {
            return {
              'mealName': meal['strMeal'] as String,
              'mealImage': meal['strMealThumb'] as String,
            };
          }).toList();

      return mealDetails;
    } else {
      // Return an empty list if no recipes were found
      return [
        {"mealName": "", "mealImage": ""},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(accountType: 'buyer', currentIndex: 1),
      body: Background(
        imagePath: 'images/content_bg.jpg',
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The background image at the top of the page
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage('images/bread.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The back button
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/product_listings', arguments: {'accountType': 'buyer'});
                      },
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                        ),
                        iconColor: WidgetStatePropertyAll(Colors.black),
                        foregroundColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowLeft),
                      label: Text(
                        "Back",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // The product name and description
                    Container(
                      width: double.infinity,
                      height: 90,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bread",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Bakery",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text("Store A | 123 Maple Street | "),
                              FaIcon(
                                FontAwesomeIcons.locationDot,
                                size: 17.0,
                                color: Colors.grey,
                              ),
                              Text(
                                " 3.21km",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              FaIcon(FontAwesomeIcons.route, size: 20.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              // The product description
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(135),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(3, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About this product",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Sunt pariatur nihil unde quidem explicabo. Nostrum, commodi! Veniam quas totam, dignissimos labore maxime minus quibusdam maiores numquam iste ad, hic repellat?",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              // The related recipes
              FutureBuilder<List<Map<String, String>>>(
                future: fetchRelatedRecipies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<Map<String, String>> mealDetails = snapshot.data!;

                    return Container(
                      constraints: BoxConstraints(minWidth: 200),
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(135),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(3, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What you can do?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                if (mealDetails.isNotEmpty)
                                  ...mealDetails.map((meal) {
                                    return Row(
                                      children: [
                                        Container(
                                          height: 100.0,
                                          width: 150.0,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                meal['mealImage']!,
                                              ),
                                              colorFilter: ColorFilter.mode(
                                                Color.fromRGBO(0, 0, 0, 0.9),
                                                BlendMode.softLight,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                meal['mealName']!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.0),
                                      ],
                                    );
                                  }),
                                if (mealDetails.isEmpty)
                                  Text('No related recipies found'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text('No meals found'));
                  }
                },
              ),
              SizedBox(height: 10.0),
              // The quantity cards
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 10.0,
                  children: [
                    ProductQuantityCard(
                      timerDuration: 65,
                      originalPrice: 3.75,
                      discount: 20,
                      quantity: 3,
                    ),
                    ProductQuantityCard(
                      timerDuration: 67,
                      originalPrice: 3.75,
                      discount: 20,
                      quantity: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
