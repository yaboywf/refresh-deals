import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductQuantityCard extends StatefulWidget {
  final int timerDuration;
  final double originalPrice;
  final int discount;
  final int quantity;

  const ProductQuantityCard({
    super.key,
    required this.timerDuration,
    required this.originalPrice,
    this.discount = 0,
    required this.quantity,
  });

  @override
  State<ProductQuantityCard> createState() => _ProductQuantityCardState();
}

class _ProductQuantityCardState extends State<ProductQuantityCard> {
  late Timer timer;
  late int secondsRemaining;

  @override
  void initState() {
    super.initState();
    secondsRemaining = widget.timerDuration;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String get timeRemaining {
    int hours = secondsRemaining ~/ 3600;
    int minutes = (secondsRemaining % 3600) ~/ 60;
    int seconds = secondsRemaining % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("Expiring in", style: TextStyle(fontSize: 12)),
          SizedBox(height: 3.0),
          Text(
            timeRemaining,
            style: TextStyle(
              color: timeRemaining != "00:00:00" ? Colors.black : Colors.red,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.discount != 0
                  ? Text(
                    '\$${widget.originalPrice.toString()}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                  : Text(
                    widget.originalPrice.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

              SizedBox(width: 5.0),

              widget.discount != 0
                  ? Text(
                    ' \$${(widget.originalPrice / 100 * (100 - widget.discount)).toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  : Text(
                    ' \$${widget.originalPrice.toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ],
          ),
          SizedBox(height: 5.0),
          widget.discount != 0
              ? Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '-${widget.discount.toString()}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              )
              : Container(),

          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.bagShopping,
                color: Colors.black,
                size: 14.0,
              ),
              SizedBox(width: 5.0),
              Text(
                '${widget.quantity} Left',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
