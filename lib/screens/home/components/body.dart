import 'package:flutter/material.dart';
import 'package:orev/screens/home/components/specialoffers.dart';
import 'package:orev/screens/home/components/threegrid.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'fourgrid.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          HomeHeader(),
          SizedBox(height: getProportionateScreenHeight(10)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageSlider(),
                  Categories(),
                  SpecialOffers(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  FourGrid(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  ThreeGrid(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                ],
              ),
            ),
          ),
          
        ],
      )
      
    );
  }
}
