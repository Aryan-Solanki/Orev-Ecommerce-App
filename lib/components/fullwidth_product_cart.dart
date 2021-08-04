import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class FullWidthProductCard extends StatefulWidget {
  final bool sale;
  final double width, aspectRetio;
  final Product product;

  const FullWidthProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
    this.sale = true,
  }) : super(key: key);

  @override
  _FullWidthProductCardState createState() => _FullWidthProductCardState();
}

class _FullWidthProductCardState extends State<FullWidthProductCard> {
  // final int saleprice = 200;
  bool outofstock = true;

  void outofstockcheck() {
    for (var varient in widget.product.varients) {
      if (varient.inStock == true) {
        outofstock = false;
        break;
      }
    }
  }

  int defaultVarient = 0;

  void getDefaultVarient() {
    int index = 0;
    for (var varient in widget.product.varients) {
      if (varient.default_product == true) {
        defaultVarient = index;
        break;
      }
      index += 1;
    }
  }

  @override
  void initState() {
    getDefaultVarient();
    outofstockcheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
            horizontal: getProportionateScreenWidth(20)),
        child: Stack(
          children: [
            Container(
              height: getProportionateScreenHeight(150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        kSecondaryColor.withOpacity(0.1), // red as border color
                  )),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(product: widget.product),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                      ),
                      width: getProportionateScreenWidth(160),
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      child: Hero(
                        tag: widget.product.id.toString(),
                        child: Image.network(
                          widget.product.varients[defaultVarient].images[0],
                          height: getProportionateScreenHeight(150),
                          width: getProportionateScreenWidth(160),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: getProportionateScreenWidth(150),
                            child: Text(
                              widget.product.title,
                              style: TextStyle(color: Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\₹${widget.product.varients[defaultVarient].price}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(17),
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              widget.sale == true
                                  ? Text(
                                      "\₹${widget.product.varients[defaultVarient].comparedPrice}",
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        // fontWeight: FontWeight.w600,
                                        color: Color(0xFF6B6B6B),
                                      ),
                                    )
                                  : Text(""),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              widget.sale == true
                                  ? Text(
                                      "Sale",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(14),
                                        color: Colors.black,
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text("")
                            ],
                          ),
                          Container(
                            width: getProportionateScreenWidth(152),
                            height: getProportionateScreenHeight(36),
                            child: outofstock == false
                                ? FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color: kPrimaryColor,
                                    onPressed: () {},
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color: kSecondaryColor,
                                    onPressed: () {},
                                    child: Text(
                                      "Out Of Stock",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                print("Cart function");
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                height: getProportionateScreenWidth(28),
                width: getProportionateScreenWidth(28),
                decoration: BoxDecoration(
                  color: widget.product.isFavourite
                      ? kPrimaryColor.withOpacity(0.15)
                      : kSecondaryColor.withOpacity(0.1),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: widget.product.isFavourite
                      ? Color(0xFFFF4848)
                      : Color(0xFFDBDEE4),
                ),
              ),
            ),
          ],
        ));
  }
}
