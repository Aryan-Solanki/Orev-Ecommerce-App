import 'package:flutter/material.dart';
import 'package:orev/constants.dart';
import 'package:orev/screens/home/components/specialoffers.dart';
import 'package:orev/screens/home/components/threegrid.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'fourgrid.dart';
import 'horizontalslider.dart';
import 'special_offers.dart';
import 'package:orev/services/product_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Widget> ListWidgets = [
    ImageSlider(),
    Categories(),
  ];

  Future<void> doSomeAsyncStuff() async {
    ProductServices _services = ProductServices();
    DocumentSnapshot variable = await _services.mainscreen.get();
    getList(variable);
  }

  void getList(variable) async {
    ProductServices _services = ProductServices();
    var ListComponents = await variable["ScreenComponents"];
    print(ListComponents);
    for (var e in ListComponents) {
      var type = e["type"];
      var categoryId = e["categoryId"].trim();
      ProductServices _services = ProductServices();
      DocumentSnapshot nameref = await _services.category.doc(categoryId).get();
      print(nameref["name"]);
      String x = nameref["name"].toString();
      var card_title = x;
      if (type == "slider_category") {
        var categoryIdList = [];
        var edata = e["data"];
        for (var catid in edata) {
          print(catid["categoryId"]);
          categoryIdList.add(catid["categoryId"]);
        }
        setState(() {
          ListWidgets.add(
            SpecialOffers(
              keys: categoryIdList,
              card_title: card_title,
            ),
          );
          ListWidgets.add(SizedBox(height: getProportionateScreenWidth(30)));
        });
      } else if (type == "3_grid") {
        var productIdList = [];
        var edata = e["data"];
        for (var catid in edata) {
          productIdList.add(catid["productId"]);
        }
        setState(() {
          ListWidgets.add(ThreeGrid(
            keys: productIdList,
            card_title: card_title,
            categoryId: categoryId,
          ));
          ListWidgets.add(SizedBox(height: getProportionateScreenWidth(30)));
        });
      } else if (type == "4_grid") {
        var productIdList = [];
        var edata = e["data"];
        for (var catid in edata) {
          print(catid["productId"]);
          productIdList.add(catid["productId"]);
        }

        setState(() {
          ListWidgets.add(FourGrid(
            keys: productIdList,
            card_title: card_title,
          ));
          ListWidgets.add(SizedBox(height: getProportionateScreenWidth(30)));
        });
      } else if (type == "slider_products") {
        var productIdList = [];
        var edata = e["data"];
        for (var catid in edata) {
          print(catid["productId"]);
          productIdList.add(catid["productId"]);
        }

        setState(() {
          ListWidgets.add(HorizontalSlider(
            keys: productIdList,
            card_title: card_title,
          ));
          ListWidgets.add(SizedBox(height: getProportionateScreenWidth(30)));
        });
      }
    }
  }

  @override
  void initState() {
    doSomeAsyncStuff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        HomeHeader(),
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: kPrimaryColor2,
              child: SingleChildScrollView(
                child: Column(
                  // children: [
                  //   ImageSlider(),
                  //   Categories(),
                  //   SpecialOffers(),
                  //   SizedBox(height: getProportionateScreenWidth(30)),
                  //   FourGrid(),
                  //   SizedBox(height: getProportionateScreenWidth(30)),
                  //   ThreeGrid(),
                  //   SizedBox(height: getProportionateScreenWidth(30)),
                  // ],
                  children: ListWidgets,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
