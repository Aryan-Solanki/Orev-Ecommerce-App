import 'package:flutter/material.dart';
import 'package:orev/screens/home/components/specialoffers.dart';
import 'package:orev/screens/home/components/threegrid.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'fourgrid.dart';
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
    var ListComponents = await variable["ScreenComponents"];
    print(ListComponents);
    for (var e in ListComponents) {
      var type = e["type"];
      if (type == "slider_category") {
        var categoryIdList = [];
        var edata = e["data"];
        for (var catid in edata) {
          print(catid["categoryId"]);
          categoryIdList.add(catid["categoryId"]);
        }
        setState(() {
          ListWidgets.add(SpecialOffers(keys: categoryIdList));
          ListWidgets.add(SizedBox(height: getProportionateScreenWidth(30)));
        });
        print(ListWidgets);
        print(ListWidgets.length);
      } else if (type == "3_grid") {}
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
      ],
    ));
  }
}
