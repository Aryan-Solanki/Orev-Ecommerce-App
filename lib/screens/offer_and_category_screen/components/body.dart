import 'package:flutter/material.dart';
import 'package:orev/screens/home/components/home_header.dart';
import 'package:orev/screens/home/components/section_title.dart';

import '../../../size_config.dart';
import 'offerzonecard.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          HomeHeader(),
          SizedBox(height: getProportionateScreenHeight(10)),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(
              title: "OfferZone",
              // categoryId: widget.categoryId,
              press: () {},
              seemore: false,
            ),
          ),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
            child: GridView.count(
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                ...List.generate(
                  10,
                  // ProductList.length,
                      (index) {
                    return OfferzoneCard();
                    // return SizedBox
                    //     .shrink(); // here by default width and height is 0
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
