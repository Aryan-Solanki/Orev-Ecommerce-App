import 'package:flutter/material.dart';
import 'package:orev/components/coustom_bottom_nav_bar.dart';
import 'package:orev/enums.dart';
import 'package:orev/models/Product.dart';

import 'components/body.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key key,
    @required this.product,
    @required this.currentVarient,
    @required this.quantity,
    @required this.selectedaddress,
  }) : super(key: key);

  final Product product;
  final int currentVarient;
  final int quantity;
  final Map<String, dynamic> selectedaddress;

  static String routeName = "/order_details";
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Body(
              key: UniqueKey(),
              product: widget.product,
              currentVarient: widget.currentVarient,
            quantity: widget.quantity,
              selectedaddress: widget.selectedaddress,
          ),
        ),
      ),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Order Now",
            style: TextStyle(color: Colors.black),
          ),
          // Text(
          //   "${demoCarts.length} items",
          //   style: Theme.of(context).textTheme.caption,
          // ),
        ],
      ),
    );
  }
}
