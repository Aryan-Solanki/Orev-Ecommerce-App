import 'package:flutter/material.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/services/product_services.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class ThreeGrid extends StatefulWidget {
  final List keys;
  const ThreeGrid({Key key, this.keys}) : super(key: key);
  @override
  _ThreeGridState createState() => _ThreeGridState(keys: keys);
}

class _ThreeGridState extends State<ThreeGrid> {
  final List keys;
  _ThreeGridState({this.keys});

  List<Product> WidgetList = [];

  Future<List<Widget>> getAllCategories() async {
    ProductServices _services = ProductServices();
    List<Widget> finalListWidget = [];

    for (var k in keys) {
      var document = await _services.products.doc(k).get();
      print(document.exists);
      print(document.get("image"));
      WidgetList.add(new Product(
        id: document.get("productId"),
        rating: 4.8,
        isFavourite: true,
        isPopular: true,
      ));
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
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          children: [
            ProductCard(
                aspectRetio: 0.89, product: demoProducts[0], width: 188),
            Column(
              children: [
                ProductCard(product: demoProducts[1], width: 127),
                SizedBox(
                  height: getProportionateScreenHeight(7),
                ),
                ProductCard(product: demoProducts[2], width: 127)
              ],
            )
          ],
        )
      ],
    );
  }
}
