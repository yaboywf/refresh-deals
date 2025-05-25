import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/background.dart';
import '../widgets/header.dart';

class ShopHomePage extends StatelessWidget {
  const ShopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // navbar
      bottomNavigationBar: NavBar(accountType: 'shop', currentIndex: 0),

      // background
      body: Background(
        padding: 20.0,
        imagePath: 'images/content_bg.jpg',
        child: SingleChildScrollView(
          // header
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),

              // welcome message
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, John Doe",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Store A",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(" | 123 Maple Street"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // quick overview
              Text(
                "Quick Overview",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  OverviewCard(title: "Expiring Soon", data: "14"),
                  Spacer(),
                  OverviewCard(title: "Average Discount", data: "18%"),
                ],
              ),
              SizedBox(height: 15),

              // items expiring
              Text(
                "Items Expiring",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Image.asset("images/graph.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DataCard(title: "From Yesterday", data: 75, type: "decrease"),
                  DataCard(title: "From 3 Days Ago", data: 0, type: "maintain"),
                  DataCard(
                    title: "From 5 Days Ago",
                    data: 33,
                    type: "decrease",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom widget for statistics display
class DataCard extends StatelessWidget {
  final String title;
  final int data;
  final String type;

  DataCard({
    super.key,
    required this.title,
    required this.data,
    required this.type,
  }) : assert(
         type == 'increase' || type == 'decrease' || type == 'maintain',
         'Type must be "increase", "decrease", or "maintain"',
       );

  // Define trend icons and colors based on type
  final trendIcon = {
    'increase': {'icon': FontAwesomeIcons.arrowTrendUp, 'color': Colors.red},
    'decrease': {
      'icon': FontAwesomeIcons.arrowTrendDown,
      'color': Colors.green,
    },
    'maintain': {'icon': FontAwesomeIcons.arrowRight, 'color': Colors.black},
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            trendIcon[type]!['icon'] as IconData,
            color: trendIcon[type]!['color'] as Color,
          ),
          Text(
            '$data%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: trendIcon[type]!['color'] as Color,
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: trendIcon[type]!['color'] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget for quick overview display
class OverviewCard extends StatelessWidget {
  final String title;
  final String data;
  const OverviewCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      width: 190,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 13.0)),
          Spacer(),
          Text(
            data,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
        ],
      ),
    );
  }
}
