import 'package:flutter/material.dart';
import 'package:orev/components/fullwidth_product_cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/home/components/section_title.dart';
import 'package:orev/services/product_services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../size_config.dart';

class AllItems extends StatefulWidget {
  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  List<Product> ProductList = [];
  List<dynamic> keys = [];

  String user_key;

  Future<void> getAllProducts() async {
    ProductServices _services = ProductServices();
    print(user_key);
    var favref = await _services.favourites.doc(user_key).get();
    keys = favref["favourites"];

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
            images: vari["variantDetails"]["images"]));
      }

      ProductList.add(new Product(
          id: document["productId"],
          brandname: document["brand"],
          varients: listVarient,
          title: document["title"],
          detail: document["detail"],
          rating: document["rating"],
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
    user_key = AuthProvider().user.uid;
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                ProductList.length,
                (index) {
                  return Dismissible(
                    key: Key(ProductList[index].id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        ProductList.removeAt(index);
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: FullWidthProductCard(
                      product: ProductList[index],
                    ),
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
