import 'package:flutter/material.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';
import 'package:orev/services/product_services.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class FourGrid extends StatefulWidget {
  final List keys;
  final String card_title;
  final String categoryId;
  const FourGrid({Key key, this.keys, this.card_title, this.categoryId})
      : super(key: key);
  @override
  _FourGridState createState() => _FourGridState(keys: keys);
}

class _FourGridState extends State<FourGrid> {
  final List keys;
  _FourGridState({this.keys});

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
            seemore: true,
            categoryId: widget.categoryId,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        GridView.count(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            ...List.generate(
              ProductList.length,
              (index) {
                return ProductCard(product: ProductList[index]);
                // return SizedBox
                //     .shrink(); // here by default width and height is 0
              },
            ),
          ],
        )
      ],
    );
  }
}
