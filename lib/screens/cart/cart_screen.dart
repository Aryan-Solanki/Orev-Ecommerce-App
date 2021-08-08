import 'package:flutter/material.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/services/product_services.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int numberOfItems = 0;
  String user_key;
  List<dynamic> keys = [];

  Future<void> getCartInfo() async {
    ProductServices _services = ProductServices();
    var favref = await _services.cart.doc(user_key).get();
    keys = favref["cartItems"];
    numberOfItems = keys.length;
    setState(() {});
  }

  @override
  void initState() {
    user_key = AuthProvider().user.uid;
    getCartInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, numberOfItems),
      body: Body(
        keys: keys,
        key: UniqueKey(),
      ),
      bottomNavigationBar: CheckoutCard(),
    );
  }
}

AppBar buildAppBar(BuildContext context, int numberOfItems) {
  return AppBar(
    title: Column(
      children: [
        Text(
          "Your Cart",
          style: TextStyle(color: Colors.black),
        ),
        Text(
          "$numberOfItems items",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    ),
  );
}
