
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:orev/models/Product.dart';

import '../../../size_config.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({
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
  _OrderInfoState createState() => _OrderInfoState();
}

bool applied_coupon=false;
String soldby = "Aryan Tatva Sellers";
class _OrderInfoState extends State<OrderInfo> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black,)
      ),
      child: Column(
        children: [
          GFAccordion(
            expandedTitleBackgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(bottom: 0,top: 0),
          titlePadding: EdgeInsets.all(0),
            titleChild: Row(
              children: [
                Container(
                  height: getProportionateScreenHeight(80),
                  width: getProportionateScreenWidth(80),
                  child: Image.network(widget.product.varients[widget.currentVarient].images[0]),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(15)),
                      ),

                    ],
                  ),
                ),

              ],
            ),

          // content: 'GetFlutter is an open source library that comes with pre-build 1000+ UI components.'
            contentChild: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                // padding: EdgeInsets.only(left: getProportionateScreenWidth(80)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sold by: $soldby",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(15)),
                    ),
                    Text(
                      "Variant: ${widget.product.varients[widget.currentVarient].title}",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(15)),
                    ),
                    Text(
                      "Quantity: ${widget.quantity}",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(15)),
                    ),
                    Text(
                      "${widget.product.detail}",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(15)),
                    )

                  ],
                ),
              ),
            ),

          ),
          Divider(
            color: Colors.black,
          ),
          GFAccordion(
            expandedTitleBackgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(bottom: 0,top: 0),
            titlePadding: EdgeInsets.all(0),
            titleChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Deliver to",style:
                TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15))),
                Text(widget.selectedaddress["name"],style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15))),

              ],
            ),
            contentChild: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.selectedaddress["adline1"],style: TextStyle(
                      fontSize: getProportionateScreenHeight(15))),
                  Text(widget.selectedaddress["adline2"],style: TextStyle(
                      fontSize: getProportionateScreenHeight(15))),
                  Text(widget.selectedaddress["city"],style: TextStyle(
                      fontSize: getProportionateScreenHeight(15))),
                  Text(widget.selectedaddress["state"],style: TextStyle(
                      fontSize: getProportionateScreenHeight(15))),
                ],
              ),
            ),


            // content: 'GetFlutter is an open source library that comes with pre-build 1000+ UI components.'

          ),
          Divider(
            color: Colors.black,
          ),
          GFAccordion(
            expandedTitleBackgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(bottom: 0,top: 0),
            titlePadding: EdgeInsets.all(0),
            titleChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pay with",style:
                TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15))),
                Text("Online Payment",style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15))),

              ],
            ),
            contentChild: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("We work hard to protect your security and privacy. Our payment security system encrypts your information during transmission. We don’t share your credit card details with third-party sellers, and we don’t sell your information to others. "),
            ),


            // content: 'GetFlutter is an open source library that comes with pre-build 1000+ UI components.'

          )
        ],
      ),
    );
  }
}
