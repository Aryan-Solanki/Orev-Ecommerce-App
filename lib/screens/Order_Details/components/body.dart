import 'package:flutter/material.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/screens/Order_Details/components/price_cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'order_info.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.product,
    @required this.currentVarient,
    @required this.quantity,
    @required this.selectedaddress
  }) : super(key: key);

  final Product product;
  final int currentVarient;
  final int quantity;
  final Map<String, dynamic> selectedaddress;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          TotalPrice(
            key: UniqueKey(),
            product: widget.product,
            currentVarient: widget.currentVarient,
            quantity: widget.quantity,
          ),
          SizedBox(height: getProportionateScreenHeight(25),),
          OrderInfo(
              key: UniqueKey(),
              product: widget.product,
              currentVarient: widget.currentVarient,
            quantity: widget.quantity,
            selectedaddress: widget.selectedaddress,
          ),
          SizedBox(height: getProportionateScreenHeight(15),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2),child: Text("By placing your order, you agree to Orev's privacy notice and conditions of use.")),
          SizedBox(height: getProportionateScreenHeight(15),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2),child: Text("If you choose to pay using an electronic payment method (credit card or debit card), you will be directed to your bank's website to complete your payment. Your contract to purchase an item will not be complete until we receive your electronic payment and dispatch your item. If you choose to pay using Pay on Delivery (POD), you can pay using cash/card/net banking when you receive your item.")),
          SizedBox(height: getProportionateScreenHeight(20),),
          DefaultButton(
            color: kPrimaryColor2,
            text: "Place Order",
            press: () {

            },
          ),
          SizedBox(height: getProportionateScreenHeight(10),),
          ],
      ),
    );
  }
}
