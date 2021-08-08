import 'package:flutter/material.dart';

import 'Product.dart';
import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;
  final int varientNumber;
  Cart(
      {@required this.product,
      @required this.numOfItem,
      @required this.varientNumber});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[0], numOfItem: 2),
];
