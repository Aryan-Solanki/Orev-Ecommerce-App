import 'package:flutter/material.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';
import 'package:orev/services/product_services.dart';
import 'package:skeletons/skeletons.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class ThreeGrid extends StatefulWidget {
  final List keys;
  final String card_title;
  final String categoryId;
  const ThreeGrid({Key key, this.keys, this.card_title, this.categoryId})
      : super(key: key);
  @override
  _ThreeGridState createState() =>
      _ThreeGridState(keys: keys, categoryId: categoryId);
}

class _ThreeGridState extends State<ThreeGrid> {
  final List keys;
  final String categoryId;
  _ThreeGridState({this.keys, this.categoryId});

  List<Product> ProductList = [];

  Future<void> getAllCategories() async {
    ProductServices _services = ProductServices();

    for (var k in keys) {
      Product product = await _services.getProduct(k);
      ProductList.add(product);
    }

    setState(() {});
    // list.add(SizedBox(width: getProportionateScreenWidth(20)));
  }

  @override
  void initState() {
    getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: widget.card_title,
            press: () {},
            categoryId: widget.categoryId,
            seemore: true,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        ProductList.length == 0
            ? SkeletonListView()
            : Row(
                children: [
                  ProductCard(
                      aspectRetio: 0.89, product: ProductList[0], width: 188),
                  Column(
                    children: [
                      ProductCard(product: ProductList[1], width: 127),
                      SizedBox(
                        height: getProportionateScreenHeight(7),
                      ),
                      ProductCard(product: ProductList[2], width: 127)
                    ],
                  )
                ],
              )
      ],
    );
  }
}
