import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orev/constants.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: getProportionateScreenWidth(20)),
          CategoryCard(
            icon: Icons.label_important_outline,
            text: "Essential",
            press: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          CategoryCard(
            icon: Icons.local_offer_outlined,
            text: "Offer Zone",
            press: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          CategoryCard(
            icon: Icons.account_balance_outlined,
            text: "Add Money",
            press: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          CategoryCard(
            icon: Icons.account_balance_wallet_outlined,
            text: "Wallet",
            press: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          CategoryCard(
            icon: Icons.redeem_outlined,
            text: "Redeem",
            press: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          CategoryCard(
            icon: Icons.card_membership_outlined,
            text: "Gift Cards",
            press: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
        ],
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

  final String  text;
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
              child: Icon(icon,color: kPrimaryColor,),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
