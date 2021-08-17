import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/home/components/home_header.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_services.dart';

import '../../../size_config.dart';
import 'cart_card.dart';
import 'check_out_card.dart';

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

  Future<void> removeFromCart(varientid, productId) async {
    ProductServices _services = ProductServices();
    print(user_key);
    var favref = await _services.cart.doc(user_key).get();
    keys = favref["cartItems"];
    bool found = false;
    var ind = 0;
    for (var cartItem in keys) {
      if (cartItem["varientNumber"] == varientid &&
          cartItem["productId"] == productId) {
        found = true;
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
      if (product == null) {
        removeFromCart(k["varientNumber"], k["productId"]);
      } else {
        var checklist =
            await getVarientNumber(k["varientNumber"], k["productId"]);
        var xx = checklist[0];
        var y = checklist[1];
        if (!y) {
          removeFromCart(k["varientNumber"], k["productId"]);
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


    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        HomeHeader(),
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
                          removeFromCart(CartList[index].varientNumber,
                              CartList[index].product.id);
                          CartList.removeAt(index);
                          widget.notifyParent();
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
                      child: CartCard(
                          cart: CartList[index],
                          notifyParent: refresh,
                          key: UniqueKey()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CheckoutCard(
          keys: keys,
          key: UniqueKey(),
        )
      ],
    );
  }
}
