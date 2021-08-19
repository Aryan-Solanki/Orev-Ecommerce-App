import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/size_config.dart';

import '../../../constants.dart';

class TotalPrice extends StatefulWidget {
  const TotalPrice({
    Key key,
    @required this.product,
    @required this.currentVarient,
    @required this.quantity,
    @required this.totalCost,
    @required this.deliveryCost,
  }) : super(key: key);
  final Product product;
  final int currentVarient;
  final int quantity;
  final double totalCost;
  final double deliveryCost;
  @override
  _TotalPriceState createState() => _TotalPriceState();
}

bool applied_coupon = false;

class _TotalPriceState extends State<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
          )),
      child: Column(
        children: [
          DetailRow(
              "Items",
              "\₹${widget.product.varients[widget.currentVarient].price} x ${widget.quantity}",
              15.0,
              FontWeight.normal,
              Color(0xff777777),
              Color(0xff777777)),
          DetailRow("Delivery", "${widget.deliveryCost}", 15.0,
              FontWeight.normal, Color(0xff777777), Color(0xff777777)),
          applied_coupon == true
              ? DetailRow("Applied Coupon", "₹0.00", 15.0, FontWeight.normal,
                  Color(0xff777777), Color(0xff777777))
              : Center(),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          DetailRow("Order Total:", "\₹${widget.totalCost}", 20.0,
              FontWeight.w800, Colors.black, kPrimaryColor),
        ],
      ),
    );
  }

  Row DetailRow(String Left, String Right, double size, FontWeight weight,
      Color colour1, Color colour2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Left,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(size),
              fontWeight: weight,
              color: colour1),
        ),
        Text(
          Right,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(size),
              fontWeight: weight,
              color: colour2),
        ),
      ],
    );
  }
}
