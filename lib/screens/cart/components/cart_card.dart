import 'package:flutter/material.dart';
import 'package:orev/components/rounded_icon_btn.dart';
import 'package:orev/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    int quantity = widget.cart.numOfItem;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(widget.cart.product
                      .varients[widget.cart.varientNumber].images[0]),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cart.product.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(20)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 3),
                  Text(
                    "${widget.cart.product.varients[widget.cart.varientNumber].title}",
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(15)),
                  ),
                  Text.rich(
                    TextSpan(
                      text:
                          "\₹${widget.cart.product.varients[widget.cart.varientNumber].price}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(20)),
                      children: [
                        TextSpan(
                            text: " x${quantity}",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: getProportionateScreenWidth(5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RoundedIconBtn(
                  width: 23.0,
                  height: 23.0,
                  colour: Color(0xFFB0B0B0).withOpacity(0.2),
                  icon: Icons.remove,
                  press: () {
                    if (quantity != 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(7)),
                Text(
                  "x" + quantity.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenHeight(20)),
                ),
                SizedBox(width: getProportionateScreenWidth(7)),
                RoundedIconBtn(
                  width: 23.0,
                  height: 23.0,
                  colour: Color(0xFFB0B0B0).withOpacity(0.2),
                  icon: Icons.add,
                  showShadow: true,
                  press: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            Text.rich(
              TextSpan(
                text:
                    "\₹${widget.cart.product.varients[widget.cart.varientNumber].price * quantity}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(20)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
