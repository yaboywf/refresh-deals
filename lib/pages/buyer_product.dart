import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyerProduct extends StatefulWidget {
  String productName;
  BuyerProduct({super.key, this.productName = ''});

  @override
  State<BuyerProduct> createState() => _BuyerProductState();
}

class _BuyerProductState extends State<BuyerProduct> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final args = ModalRoute.of(context)?.settings.arguments;
    
    if (args != null && args is Map<String, dynamic> && args.containsKey('productName')) {
      widget.productName = args['productName'];
    }

    fetchRelatedRecipies();
  }

  Future<List<Map<String, String>>> fetchRelatedRecipies() async {
    final url = 'https://www.themealdb.com/api/json/v1/1/search.php';
    final response = await http.get(Uri.parse('$url?s=${widget.productName}'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> meals = data['meals'] ?? [];
      List<Map<String, String>> mealDetails = meals.map((meal) {
        return {
          'mealName': meal['strMeal'] as String,
          'mealImage': meal['strMealThumb'] as String,
        };
      }).toList();

      return mealDetails;
    } else {
      return [{"mealName": "", "mealImage": ""}];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(accountType: 'buyer', currentIndex: 1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/buyer_shop');
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
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
              FutureBuilder<List<Map<String, String>>>(
                future: fetchRelatedRecipies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
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
                        color: Color.fromRGBO(255, 255, 255, 0.9),
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
                                  }
                                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
