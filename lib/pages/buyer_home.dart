import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import '../services/firebase_service.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/quick_nav_widget.dart';
import '../widgets/product_overview_card.dart';
import '../widgets/background.dart';

/// Homepage for buyers
/// Shown when the user is logged in
///
/// Contains:
/// - Quick navigation choices
/// - Recommended Products (by system)
/// - Top Deals (ranked based on the discount percentage)
class BuyerHomepage extends StatelessWidget {
  BuyerHomepage({super.key});
  final FirebaseService fbService = GetIt.instance<FirebaseService>();

  /// List of quick navigation choices
  /// List of categories that the user can search by
  final choicesList = List<Map>.from([
    {"icon": FontAwesomeIcons.carrot, "text": "Vegetable", "color": Colors.blue.shade100},
    {"icon": FontAwesomeIcons.apple, "text": "Fruit", "color": const Color.fromRGBO(144, 238, 144, 1)},
    {"icon": FontAwesomeIcons.drumstickBite, "text": "Meat", "color": Colors.orange},
    {"icon": FontAwesomeIcons.breadSlice, "text": "Pastry", "color": const Color.fromRGBO(189, 179, 255, 1)},
    {"icon": FontAwesomeIcons.ellipsis, "text": "Others", "color": const Color.fromRGBO(255, 179, 232, 1)},
  ]);

  /// Sample list of recommended products
  final recommendationList = List<Map>.from([
    {"image": "images/bread.webp", "name": "Bread", "discount": 20, "storeName": "Store A", "address": "123 Maple Street"},
    {"image": "images/cabbage.png", "name": "Cabbage", "discount": 30, "storeName": "Store B", "address": "234 Cesar Road"},
    {"image": "images/muffin.png", "name": "Muffin", "discount": 20, "storeName": "Store A", "address": "123 Maple Street"},
  ]);

  /// Sample list of top deals
  final topDealsList = List<Map>.from([
    {"image": "images/cabbage.png", "name": "Cabbage", "discount": 50, "storeName": "Store C", "address": "972 Cesar Road"},
    {"image": "images/orange.png", "name": "Orange", "discount": 30, "storeName": "Store B", "address": "234 Cesar Road"},
    {"image": "images/muffin.png", "name": "Muffin", "discount": 40, "storeName": "Store D", "address": "451 Maple Street"},
  ]);

  Future<List<Map>> fetchRecommendedProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return recommendationList;
  }

  Future<List<Map>> fetchTopDeals() async {
    await Future.delayed(const Duration(seconds: 2));
    return topDealsList;
  }

  @override
  Widget build(BuildContext context) {
    // If the user is not logged in, redirect to the login page
    if (fbService.getCurrentUser() == null) {
      Future.microtask(() {
        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
      });
      return SizedBox();
    }

    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: Background(
        imagePath: 'images/content_bg.jpg',
        padding: 20.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// User's greeting
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, ${fbService.getCurrentUser()!.displayName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text("Another great day to", style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                        Text(" shop ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade700)),
                        Text("and", style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                        Text(" save ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade700)),
                        Text("the world!", style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                      ],
                    ),
                  ],
                ),
              ),

              /// Categories
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 15.0,
                  spacing: 5.0,
                  children: List.generate(choicesList.length, (index) {
                    return Choices(icon: choicesList[index]["icon"], color: choicesList[index]["color"], text: choicesList[index]["text"]);
                  }),
                ),
              ),

              /// Recommended products
              Text("Recommended by Us", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<Map>>(
                  future: fetchRecommendedProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: Colors.black));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading recommendations'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No recommendations available'));
                    } else {
                      final recommendationList = snapshot.data!;
                      return Row(
                        children: List.generate(recommendationList.length * 2 - 1, (index) {
                          // Add a space between items
                          if (index.isEven) {
                            final itemIndex = index ~/ 2;
                            return ProductOverviewCard(
                              image: recommendationList[itemIndex]["image"],
                              name: recommendationList[itemIndex]["name"],
                              discount: recommendationList[itemIndex]["discount"],
                              storeName: recommendationList[itemIndex]["storeName"],
                              address: recommendationList[itemIndex]["address"],
                              onTap: () => Navigator.pushNamed(context, '/buyer_product'),
                            );
                          } else {
                            return SizedBox(width: 10.0);
                          }
                        }),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20.0),
              // Top deals
              Text("Top Deals", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<Map>>(
                  future: fetchTopDeals(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: Colors.black));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading recommendations'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No recommendations available'));
                    } else {
                      final topDealsList = snapshot.data!;

                      return Row(
                        children: List.generate(topDealsList.length * 2 - 1, (index) {
                          if (index.isEven) {
                            // Add a space between items
                            final itemIndex = index ~/ 2;
                            return ProductOverviewCard(
                              image: topDealsList[itemIndex]["image"],
                              name: topDealsList[itemIndex]["name"],
                              discount: topDealsList[itemIndex]["discount"],
                              storeName: topDealsList[itemIndex]["storeName"],
                              address: topDealsList[itemIndex]["address"],
                              onTap: () => Navigator.pushNamed(context, '/buyer_product'),
                            );
                          } else {
                            return SizedBox(width: 10.0);
                          }
                        }),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
