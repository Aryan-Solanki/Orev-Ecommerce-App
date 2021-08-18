import 'package:flutter/material.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/cart/cart_screen.dart';
import 'package:orev/screens/sign_in/sign_in_screen.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_simple_preferences.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  final bool simplebutton;
  final Function func;
  const HomeHeader({
    bool this.simplebutton = true,
    @required this.func,
    Key key,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int numberOfItems = 0;
  String user_key;
  List<dynamic> keys = [];
  String authkey = '';

  Future<void> getCartNumber() async {
    ProductServices _services = ProductServices();
    var favref = await _services.cart.doc(user_key).get();
    keys = favref["cartItems"];
    numberOfItems = keys.length;
    setState(() {});
  }

  @override
  void initState() {
    authkey = UserSimplePreferences.getAuthKey() ?? '';
    if (authkey != "") {
      user_key = AuthProvider().user.uid;
      getCartNumber();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCartNumber();
    function(value, boo) {
      widget.func(value, boo);
    }

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(
            simplebutton: widget.simplebutton,
            func: function,
          ),
          numberOfItems == 0
              ? IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  press: () {
                    if (authkey == '') {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    } else {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    }
                  },
                )
              : IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  numOfitem: numberOfItems,
                  press: () {
                    if (authkey == '') {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    } else {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    }
                  },
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
