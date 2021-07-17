import 'package:flutter/material.dart';
import 'package:orev/components/fullwidth_product_cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/screens/home/components/section_title.dart';

import '../../../size_config.dart';

class AllItems extends StatelessWidget {
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
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                demoProducts.length,
                    (index) {
                  if (demoProducts[index].isPopular)
                    return FullWidthProductCard(product: demoProducts[index],);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}