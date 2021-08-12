import 'package:flutter/material.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';
import 'package:orev/services/product_services.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class HorizontalSlider extends StatefulWidget {
  final List keys;
  final String card_title;
  final String categoryId;
  const HorizontalSlider({Key key, this.keys, this.card_title, this.categoryId})
      : super(key: key);
  @override
  _HorizontalSliderState createState() => _HorizontalSliderState(keys: keys);
}

class _HorizontalSliderState extends State<HorizontalSlider> {
  final List keys;
  _HorizontalSliderState({this.keys});

  List<Product> ProductList = [];

  Future<void> getAllCategories() async {
    ProductServices _services = ProductServices();

    for (var k in keys) {
      var document = await _services.products.doc(k).get();
      print(document.exists);
      var listVarientraw = document["variant"];
      print(listVarientraw);
      List<Varient> listVarient = [];
      for (var vari in listVarientraw) {
        print(vari["variantDetails"]["title"]);
        print(vari["variantDetails"]["title"]);
        listVarient.add(new Varient(
            default_product: vari["default"],
            isOnSale: vari["onSale"]["isOnSale"],
            comparedPrice: vari["onSale"]["comparedPrice"].toDouble(),
            discountPercentage: vari["onSale"]["discountPercentage"].toDouble(),
            price: vari["price"].toDouble(),
            inStock: vari["stock"]["inStock"],
            qty: vari["stock"]["qty"],
            title: vari["variantDetails"]["title"],
            id: vari["id"],
            images: vari["variantDetails"]["images"]));
      }

      ProductList.add(new Product(
          id: document["productId"],
          brandname: document["brand"],
          varients: listVarient,
          title: document["title"],
          detail: document["detail"],
          rating: document["rating"],
          sellerId: document["sellerId"],
          isFavourite: false,
          isPopular: true,
          tax: document["tax"].toDouble(),
          youmayalsolike: document["youMayAlsoLike"]));
    }

    print(ProductList.length);
    print(ProductList.length);
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                ProductList.length,
                (index) {
                  return ProductCard(product: ProductList[index]);
                  // return SizedBox
                  //     .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
