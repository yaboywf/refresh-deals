import 'package:flutter/material.dart';

/// A widget that displays a card for a product in the product listing page.
class ProductOverviewCard extends StatelessWidget {
  final String image;
  final String name;
  final int discount;
  final String storeName;
  final String address;

  const ProductOverviewCard({
    super.key,
    required this.image,
    required this.name,
    required this.discount,
    required this.storeName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 130,
        width: 230,
        child: Stack(
          children: [
            // The product image
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            // The product details
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 62,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The product name and discount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '-$discount%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // The store name and address
                    Text(
                      '$storeName | $address',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
