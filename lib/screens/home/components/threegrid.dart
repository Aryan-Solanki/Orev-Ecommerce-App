import 'package:flutter/material.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class ThreeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          children: [
            ProductCard(aspectRetio:0.89,product: demoProducts[0],width: 188),
            Column(
              children: [
                ProductCard(product: demoProducts[1],width: 127),
                SizedBox(height: getProportionateScreenHeight(7),),
                ProductCard(product: demoProducts[2],width: 127)
              ],
            )
          ],
        )
      ],
    );
  }
}
