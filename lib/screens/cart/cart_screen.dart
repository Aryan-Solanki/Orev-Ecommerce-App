import 'package:flutter/material.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/services/product_services.dart';

import '../../constants.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  final Map address;
  CartScreen({this.address, Key key}) : super(key: key);
  static String routeName = "/cart";
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
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
      // final snackBar = SnackBar(
      //   content: Text('Cart Updated'),
      //   backgroundColor: kPrimaryColor,
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(
          currentAddress: widget.address,
          keys: keys,
          key: UniqueKey(),
          notifyParent: refresh,
        ),
      ),
    );
  }
}
