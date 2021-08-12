import 'package:flutter/material.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/services/product_services.dart';

import '../../constants.dart';
import 'components/body.dart';


class YourOrder extends StatefulWidget {
  static String routeName = "/your_order";
  @override
  _YourOrderState createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
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

  refresh() async {
    ProductServices _services = ProductServices();
    var favref = await _services.cart.doc(user_key).get();
    keys = favref["cartItems"];
    setState(() {
      final snackBar = SnackBar(
        content: Text('Cart Updated'),
        backgroundColor: kPrimaryColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, numberOfItems),
      body: Body(
        keys: keys,
        key: UniqueKey(),
        notifyParent: refresh,
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context, int numberOfItems) {
  return AppBar(
    title: Column(
      children: [
        Text(
          "Your Orders",
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
