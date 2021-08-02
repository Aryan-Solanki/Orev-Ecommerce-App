import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orev/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key key,
    @required this.product,
  }) : super(key: key);
  final Product product;

  @override
  _ProductDescriptionState createState() =>
      _ProductDescriptionState(product: this.product);
}

class _ProductDescriptionState extends State<ProductDescription> {
  _ProductDescriptionState({
    @required this.product,
  });
  final Product product;
  bool seemore = false;
  bool sale = true;
  int saleprice = 200;
  String brandname = "ORGANIC TATTVA";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(7)),
          child: Text(
            product.brandname,
            style: verysmallerheadingStyle,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                children: [
                  sale == true
                      ? Text(
                          "\₹${saleprice}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(23),
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        )
                      : Text(
                          "\₹${product.varients[0].price}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(23),
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                  SizedBox(
                    width: getProportionateScreenWidth(20),
                  ),
                  sale == true
                      ? Text(
                          "\₹${product.varients[0].price}",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: getProportionateScreenWidth(13),
                            // fontWeight: FontWeight.w600,
                            color: Color(0xFF6B6B6B),
                          ),
                        )
                      : Text(""),
                  SizedBox(
                    width: getProportionateScreenWidth(5),
                  ),
                  sale == true
                      ? Text(
                          "Sale",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: product.isFavourite
                      ? Color(0xFFFFE6E6)
                      : Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: product.isFavourite
                      ? Color(0xFFFF4848)
                      : Color(0xFFDBDEE4),
                  height: getProportionateScreenWidth(16),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: seemore == true
              ? Text(
                  product.detail,
                )
              : Text(
                  product.detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: 10,
            ),
            child: seemore == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        seemore = false;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "See Less Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        seemore = true;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "See More Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ))
      ],
    );
  }
}
