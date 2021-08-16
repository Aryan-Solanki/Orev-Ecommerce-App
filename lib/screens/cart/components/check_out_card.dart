import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_services.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  final List<dynamic> keys;
  const CheckoutCard({Key key, this.keys}) : super(key: key);
  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  String coupon = "";
  List<Cart> CartList = [];
  double totalamt = 0.0;

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

  // Future<void> getAllCartProducts() async {
  //   for (var k in widget.keys) {
  //     ProductServices _services = new ProductServices();
  //     UserServices _user_services = new UserServices();
  //     Product product = await _services.getProduct(k["productId"]);
  //     var checklist =
  //         await getVarientNumber(k["varientNumber"], k["productId"]);
  //     var xx = checklist[0];
  //     var y = checklist[1];
  //     if (!y) {
  //       continue;
  //     }
  //     CartList.add(new Cart(
  //         product: product,
  //         varientNumber: product.varients[xx].id,
  //         numOfItem: k["qty"]));
  //     if (_user_services.isAvailableOnUserLocation()) {
  //       totalamt += product.varients[xx].price * k["qty"];
  //     }
  //   }
  //   setState(() {
  //     print(totalamt);
  //   });
  // }

  Future<void> removeFromCart(varientid, productId) async {
    ProductServices _services = ProductServices();
    print(user_key);
    var favref = await _services.cart.doc(user_key).get();
    var keys = favref["cartItems"];
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
    // final snackBar = SnackBar(
    //   content: Text('Item removed from Cart'),
    //   backgroundColor: kPrimaryColor,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // list.add(SizedBox(width: getProportionateScreenWidth(20)));
  }

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
    // getAllCartProducts();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Container(
                    width: getProportionateScreenWidth(120),
                    child: TextField(
                      onChanged: (value) {
                        print(value);
                        coupon = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter code',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\₹$totalamt",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      text: "Check Out",
                      press: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
