import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductDetailsCard extends StatelessWidget {
  // Account type to determine navigation behavior
  String accountType;
  // Product details to be displayed
  final Map<String, dynamic> product;

  ProductDetailsCard({
    super.key,
    required this.product,
    this.accountType = 'buyer',
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve route arguments, if available
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // Override accountType if provided in arguments
    if (arguments != null && arguments.containsKey('accountType')) {
      accountType = arguments['accountType']!;
    }

    return GestureDetector(
      key: Key(product['id'].toString()),
      onTap: () {
        // Navigate based on account type
        if (accountType == 'buyer') {
          Navigator.pushReplacementNamed(
            context,
            "/buyer_product",
            arguments: {'productName': product['name']},
          );
        } else {
          Navigator.pushReplacementNamed(context, "/shop_editor");
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(255, 255, 255, 0.7),
        ),
        child: Row(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'images/bread.webp',
                width: 90,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 10),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name and category
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bread',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          "Bakery",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Pricing and discount
                  Row(
                    children: [
                      Text(
                        '\$3.00 - \$4.50',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 96, 161, 129),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        child: Text(
                          '-20%',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Stock and expiry information
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.red,
                        ),
                        child: Text(
                          '2 Expiring',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 47, 111, 50),
                        ),
                        child: Text(
                          '10 Available',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  // Store information for buyers
                  Column(
                    children: [
                      if (accountType != 'shop') ...[
                        SizedBox(height: 5),
                        Text(
                          "Store A | 123 Maple Street",
                          style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
