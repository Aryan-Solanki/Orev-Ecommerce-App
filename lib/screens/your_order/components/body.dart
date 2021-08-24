import 'package:flutter/material.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Order.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/home/components/home_header.dart';
import 'package:orev/screens/your_order/components/your_order_cart.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_services.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  final List<dynamic> keys;
  final Function() notifyParent;
  const Body({
    Key key,
    this.keys,
    @required this.notifyParent,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState(keys: keys);
}

class _BodyState extends State<Body> {
  List<Order> keys;
  _BodyState({@required this.keys});

  String user_key;

  @override
  void initState() {
    user_key = AuthProvider().user.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    refresh() {
      setState(() {
        widget.notifyParent();
      });
    }

    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        HomeHeader(),
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: kPrimaryColor2,
                child: ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: YouOrderCard(
                        order: keys[index], notifyParent: refresh, key: UniqueKey()),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
