import 'package:flutter/material.dart';
import 'package:orev/components/fullwidth_product_cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';
import 'package:orev/screens/home/components/section_title.dart';
import 'package:orev/services/product_services.dart';

import '../../../size_config.dart';

class AllItems extends StatefulWidget {
  final String categoryId;
  final String title;
  final Function() notifyParent;
  AllItems({this.categoryId, this.title, @required this.notifyParent});

  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  List<Product> ProductList = [];
  List<dynamic> keys = [];

  Future<void> getAllProducts() async {
    ProductServices _services = ProductServices();

    var _documentRef = await _services.products;
    print(widget.categoryId);
    print(widget.categoryId);
    await _documentRef.get().then((ds) {
      if (ds != null) {
        ds.docs.forEach((value) {
          List val = value["categories"];
          if (val.contains(widget.categoryId)) {
            print(value["productId"]);
            keys.add(value["productId"].trim());
          }
        });
      }
    });

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
            id: vari["id"],
            title: vari["variantDetails"]["title"],
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
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    refresh() {
      setState(() {
        // print("Set state ho gyaaAAAA");
        widget.notifyParent();
      });
    }

    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: widget.title,
            categoryId: widget.categoryId,
            press: () {},
            seemore: false,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                ProductList.length,
                    (index) {
                  return FullWidthProductCard(
                    product: ProductList[index],
                    notifyParent: refresh,
                  );

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
