import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Category.dart';
import 'package:orev/screens/category_page/category_page.dart';
import 'package:orev/screens/offer_and_category_screen/offerzone_and_category.dart';
import 'package:orev/screens/seemore/seemore.dart';
import 'package:orev/screens/allCategoriesScreen/allCategoriesScreen.dart';
import 'package:orev/screens/sign_in/sign_in_screen.dart';

import 'package:orev/screens/wallet/wallet.dart';
import 'package:orev/services/user_simple_preferences.dart';

import '../../../size_config.dart';

class Categories extends StatefulWidget {
  final int categoryint;

  const Categories({
    Key key,
    @required this.categoryint,
  }) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String authkey = '';

  @override
  void initState() {
    authkey = UserSimplePreferences.getAuthKey() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.categoryint == 1
                ? CategoryCard(
                    icon: Icons.local_offer_outlined,
                    text: "Offer\nZone",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferzoneCategory()),
                      );
                    },
                  )
                : CategoryCard(
                    icon: Icons.fastfood_outlined,
                    text: "Food",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeMore(
                                  categoryId: "43Gm8DaBXRsLPMCPw4ZZ",
                                  title: "Food")));
                    },
                  ),
            SizedBox(width: getProportionateScreenWidth(20)),
            widget.categoryint == 1
                ? CategoryCard(
                    icon: Icons.account_balance_outlined,
                    text: "Wallet",
                    press: () {
                      if (authkey == '') {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      } else {
                        Navigator.pushNamed(context, Wallet.routeName);
                      }
                    },
                  )
                : CategoryCard(
                    icon: Icons.health_and_safety_outlined,
                    text: "Health",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeMore(
                                  categoryId: "2f3ipLs8hmLEYEJk3xjn",
                                  title: "Health")));
                    },
                  ),
            SizedBox(width: getProportionateScreenWidth(20)),
            widget.categoryint == 1
                ? CategoryCard(
                    icon: Icons.people_outline_rounded,
                    text: "Experts",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeMore(
                                  categoryId: "pmGbfQHUi0Z5TTrk6wLQ",
                                  title: "Experts")));
                    },
                  )
                : CategoryCard(
                    icon: Icons.female_outlined,
                    text: "Beauty",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeMore(
                                  categoryId: "fe29yWr3MDBvPN7tdndB",
                                  title: "Beauty")));
                    },
                  ),
            SizedBox(width: getProportionateScreenWidth(20)),
            widget.categoryint == 1
                ? CategoryCard(
                    icon: Icons.library_books_outlined,
                    text: "E-Books",
                    press: () {
                      Fluttertoast.showToast(
                          msg: "Service Coming Soon",
                          toastLength: Toast.LENGTH_LONG,
                          timeInSecForIosWeb: 2,
                          gravity: ToastGravity.BOTTOM);
                    },
                  )
                : CategoryCard(
                    icon: Icons.label_important_outline,
                    text: "Essentials",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                  categoryId: "JAgrZhNaIa3ryRug2wrn",
                                  title: "Essentials",
                                )),
                      );
                    },
                  ),
            SizedBox(width: getProportionateScreenWidth(20)),
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
            Text(text,
                style: TextStyle(fontSize: getProportionateScreenWidth(12)),
                textAlign: TextAlign.center),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
