import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Category.dart';
import 'package:orev/screens/category_page/category_page.dart';

import 'package:orev/screens/wallet/wallet.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryCard(
              icon: Icons.label_important_outline,
              text: "Essential", 
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage(categoryId: "JAgrZhNaIa3ryRug2wrn",title: "Essentials",)),
                );
              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            CategoryCard(
              icon: Icons.local_offer_outlined,
              text: "Offer\nZone",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage(categoryId: "JAgrZhNaIa3ryRug2wrn",title: "Offer Zone",)),
                );
              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            CategoryCard(
              icon: Icons.account_balance_outlined,
              text: "Wallet",
              press: () {
                Navigator.pushNamed(context, Wallet.routeName);
              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            CategoryCard(
              icon: Icons.new_label_outlined,
              text: "Fresh",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage(categoryId: "JAgrZhNaIa3ryRug2wrn",title: "Fresh",)),
                );

              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            CategoryCard(
              icon: Icons.category_outlined,
              text: "Category",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage(categoryId: "JAgrZhNaIa3ryRug2wrn",title: "Category",)),
                );
              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            CategoryCard(
              icon: Icons.thumb_up_alt_outlined,
              text: "Best\nSellers",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage(categoryId: "JAgrZhNaIa3ryRug2wrn",title: "Best Sellers",)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xffE1FDE1),
                borderRadius: BorderRadius.circular(10),
              ),
              // child: SvgPicture.asset(icon),
              child: Icon(
                icon,
                size: getProportionateScreenWidth(23),
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 5),
            Text(text,style: TextStyle(fontSize: getProportionateScreenWidth(12)), textAlign: TextAlign.center),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
