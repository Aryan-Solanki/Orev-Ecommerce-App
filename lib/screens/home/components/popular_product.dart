import 'package:flutter/material.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
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
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            ...List.generate(
              demoProducts.length,
              (index) {
                if (demoProducts[index].isPopular)
                  return ProductCard(product: demoProducts[index]);

                return SizedBox
                    .shrink(); // here by default width and height is 0
              },
            ),
          ],
        )
      ],
    );
  }
}
