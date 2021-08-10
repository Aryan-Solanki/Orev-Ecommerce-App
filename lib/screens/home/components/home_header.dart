import 'package:flutter/material.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/cart/cart_screen.dart';
import 'package:orev/services/product_services.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int numberOfItems = 0;
  String user_key;
  List<dynamic> keys = [];

  Future<void> getCartNumber() async {
    ProductServices _services = ProductServices();
    print(user_key);
    var favref = await _services.cart.doc(user_key).get();
    keys = favref["cartItems"];
    numberOfItems = keys.length;
    setState(() {});
  }

  @override
  void initState() {
    user_key = AuthProvider().user.uid;
    getCartNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCartNumber();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          numberOfItems == 0
              ? IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  press: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                )
              : IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  numOfitem: numberOfItems,
                  press: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
