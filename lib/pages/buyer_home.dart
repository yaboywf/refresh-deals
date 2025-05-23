import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/quick_nav_widget.dart';
import '../widgets/product_overview_card.dart';
import '../widgets/background.dart';

class BuyerHomepage extends StatelessWidget {
  BuyerHomepage({super.key});

  final choicesList = List<Map>.from([
    {
      "icon": FontAwesomeIcons.carrot,
      "text": "Vegetable",
      "color": Colors.blue.shade100,
    },
    {
      "icon": FontAwesomeIcons.apple,
      "text": "Fruit",
      "color": const Color.fromRGBO(144, 238, 144, 1),
    },
    {
      "icon": FontAwesomeIcons.drumstickBite,
      "text": "Meat",
      "color": Colors.orange,
    },
    {
      "icon": FontAwesomeIcons.breadSlice,
      "text": "Pastry",
      "color": const Color.fromRGBO(189, 179, 255, 1),
    },
    {
      "icon": FontAwesomeIcons.ellipsis,
      "text": "Others",
      "color": const Color.fromRGBO(255, 179, 232, 1),
    },
  ]);

  final recommendationList = List<Map>.from([
    {
      "image": "images/bread.webp",
      "name": "Bread",
      "discount": 20,
      "storeName": "Store A",
      "address": "123 Maple Street",
    },
    {
      "image": "images/cabbage.png",
      "name": "Cabbage",
      "discount": 30,
      "storeName": "Store B",
      "address": "234 Cesar Road",
    },
    {
      "image": "images/muffin.png",
      "name": "Muffin",
      "discount": 20,
      "storeName": "Store A",
      "address": "123 Maple Street",
    },
  ]);

  final topDealsList = List<Map>.from([
    {
      "image": "images/cabbage.png",
      "name": "Cabbage",
      "discount": 50,
      "storeName": "Store C",
      "address": "972 Cesar Road",
    },
    {
      "image": "images/orange.png",
      "name": "Orange",
      "discount": 30,
      "storeName": "Store B",
      "address": "234 Cesar Road",
    },
    {
      "image": "images/muffin.png",
      "name": "Muffin",
      "discount": 40,
      "storeName": "Store D",
      "address": "451 Maple Street",
    },
  ]);

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Another great day to",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          " shop ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "and",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          " save ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "the world!",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 15.0,
                  spacing: 5.0,
                  children: List.generate(choicesList.length, (index) {
                    return Choices(
                      icon: choicesList[index]["icon"],
                      color: choicesList[index]["color"],
                      text: choicesList[index]["text"],
                    );
                  }),
                ),
              ),
              Text(
                "Recommended by Us",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(recommendationList.length * 2 - 1, (
                    index,
                  ) {
                    if (index.isEven) {
                      final itemIndex = index ~/ 2;
                      return ProductOverviewCard(
                        image: recommendationList[itemIndex]["image"],
                        name: recommendationList[itemIndex]["name"],
                        discount: recommendationList[itemIndex]["discount"],
                        storeName: recommendationList[itemIndex]["storeName"],
                        address: recommendationList[itemIndex]["address"],
                      );
                    } else {
                      return SizedBox(width: 10.0);
                    }
                  }),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Top Deals",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(topDealsList.length * 2 - 1, (index) {
                    if (index.isEven) {
                      final itemIndex = index ~/ 2;
                      return ProductOverviewCard(
                        image: topDealsList[itemIndex]["image"],
                        name: topDealsList[itemIndex]["name"],
                        discount: topDealsList[itemIndex]["discount"],
                        storeName: topDealsList[itemIndex]["storeName"],
                        address: topDealsList[itemIndex]["address"],
                      );
                    } else {
                      return SizedBox(width: 10.0);
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
