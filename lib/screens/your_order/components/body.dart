import 'package:flutter/material.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/providers/auth_provider.dart';
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
  List<dynamic> keys;
  _BodyState({@required this.keys});

  List<Cart> CartList = [];
  double totalamt = 0.0;

  Future<void> removeFromCart(varientid) async {
    ProductServices _services = ProductServices();
    print(user_key);
    var favref = await _services.cart.doc(user_key).get();
    keys = favref["cartItems"];

    var ind = 0;
    for (var cartItem in keys) {
      if (cartItem["varientNumber"] == varientid) {
        break;
      }
      ind += 1;
    }
    keys.removeAt(ind);
    await _services.cart.doc(user_key).update({'cartItems': keys});
    widget.notifyParent();
  }

  Future<List> getVarientNumber(id, productId) async {
    ProductServices _services = ProductServices();
    print(user_key);
    var product = await _services.getProduct(productId);
    var varlist = product.varients;
    int ind = 0;
    bool foundit = false;
    for (var varient in varlist) {
      if (varient.id == id) {
        foundit = true;
        break;
      }
      ind += 1;
    }
    return [ind, foundit];
  }

  String user_key;

  Future<void> getAllCartProducts() async {
    for (var k in widget.keys) {
      ProductServices _services = new ProductServices();
      UserServices _user_services = new UserServices();
      Product product = await _services.getProduct(k["productId"]);
      var checklist =
      await getVarientNumber(k["varientNumber"], k["productId"]);
      var xx = checklist[0];
      var y = checklist[1];
      if (!y) {
        removeFromCart(k["varientNumber"]);
        continue;
      }
      CartList.add(new Cart(
          product: product,
          varientNumber: product.varients[xx].id,
          numOfItem: k["qty"]));
      if (_user_services.isAvailableOnUserLocation()) {
        totalamt += product.varients[xx].price * k["qty"];
      }
    }
    setState(() {
      print(totalamt);
    });
  }

  @override
  void initState() {
    user_key = AuthProvider().user.uid;
    getAllCartProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    refresh() {
      setState(() {
        widget.notifyParent();
      });
    }

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
              child: YouOrderCard(
                  cart: CartList[index],
                  notifyParent: refresh,
                  key: UniqueKey()),
            ),
          ),
        ),
      ),
    );
  }
}
