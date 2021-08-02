import 'package:flutter/material.dart';

class Varient {
  final bool default_product;
  final bool isOnSale;
  final double comparedPrice, discountPercentage;
  final double price;
  final bool inStock;
  final double qty;
  final String title;
  final List<String> images;

  Varient({
    @required this.default_product,
    @required this.isOnSale,
    @required this.comparedPrice,
    @required this.discountPercentage,
    @required this.price,
    @required this.inStock,
    @required this.qty,
    @required this.title,
    @required this.images,
  });
}
