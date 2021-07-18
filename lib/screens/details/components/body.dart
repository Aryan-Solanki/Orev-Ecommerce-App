import 'package:flutter/material.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;
  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(product:this.product);
}

class _BodyState extends State<Body> {
  _BodyState({@required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.1,
                          right: SizeConfig.screenWidth * 0.1,
                          bottom: getProportionateScreenWidth(30),
                          top: getProportionateScreenWidth(10),
                        ),
                        child: Column(
                          children: [
                            DefaultButton(
                              color: kPrimaryColor2,
                              text: "Buy Now",
                              press: () {},
                            ),
                            SizedBox(height:getProportionateScreenHeight(15) ,),
                            DefaultButton(
                              text: "Add To Cart",
                              press: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
