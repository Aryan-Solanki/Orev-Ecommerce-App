import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orev/components/fullwidth_product_cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';
import 'package:orev/screens/home/components/section_title.dart';
import 'package:orev/services/product_services.dart';

import '../../../size_config.dart';

class AllItems extends StatefulWidget {
  final List<Product> productList;
  final String title;
  final Function() notifyParent;
  AllItems({this.productList, this.title, @required this.notifyParent, Key key})
      : super(key: key);

  @override
  AllItemsState createState() => AllItemsState();
}

class AllItemsState extends State<AllItems> {
  List<Product> ProductList = [];

  @override
  void initState() {
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

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Text(
          "Search Results for '${widget.title}'",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: widget.productList.length == 0
            ? Center(
                child: Text("No products to display"),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: widget.productList.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return FullWidthProductCard(
                    product: widget.productList[index],
                    notifyParent: refresh,
                  );
                }),
      ),
    ]);
  }
}
