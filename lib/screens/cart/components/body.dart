import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/services/product_services.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final List<dynamic> keys;
  const Body({Key key, this.keys}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(keys: keys);
}

class _BodyState extends State<Body> {
  List<dynamic> keys;
  _BodyState({@required this.keys});

  List<Cart> CartList = [];

  Future<void> getAllCartProducts() async {
    for (var k in keys) {
      ProductServices _services = new ProductServices();
      Product product = await _services.getProduct(k["productId"]);
      CartList.add(new Cart(
          product: product,
          varientNumber: k["varientNumber"],
          numOfItem: k["qty"]));
    }
    setState(() {});
  }

  @override
  void initState() {
    getAllCartProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: kPrimaryColor2,
          child: ListView.builder(
            itemCount: CartList.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(CartList[index].product.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    demoCarts.removeAt(index);
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(cart: CartList[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
