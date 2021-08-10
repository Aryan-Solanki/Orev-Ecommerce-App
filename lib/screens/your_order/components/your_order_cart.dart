import 'package:flutter/material.dart';
import 'package:orev/components/rounded_icon_btn.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/services/product_services.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class YouOrderCard extends StatefulWidget {
  const YouOrderCard({
    Key key,
    @required this.cart,
    @required this.notifyParent,
  }) : super(key: key);

  final Cart cart;
  final Function() notifyParent;

  @override
  _YouOrderCardState createState() => _YouOrderCardState();
}

class _YouOrderCardState extends State<YouOrderCard> {
  String user_key;
  int selectedVarient = 0;

  Future<int> getVarientNumber(id, productId) async {
    ProductServices _services = ProductServices();
    print(user_key);
    Product product = await _services.getProduct(productId);
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
    selectedVarient = ind;
    setState(() {});
  }

  Future<void> changeCartQty(quantity) async {
    ProductServices _services = ProductServices();
    print(user_key);
    var favref = await _services.cart.doc(user_key).get();
    var keys = favref["cartItems"];

    for (var k in keys) {
      if (k["varientNumber"] == widget.cart.varientNumber) {
        k["qty"] = quantity;
        break;
      }
    }
    await _services.cart.doc(user_key).update({'cartItems': keys});
    setState(() {
      widget.notifyParent();
    });
    // list.add(SizedBox(width: getProportionateScreenWidth(20)));
  }

  Future<void> removeFromCart(varientid) async {
    ProductServices _services = ProductServices();
    print(user_key);
    var favref = await _services.cart.doc(user_key).get();
    var keys = favref["cartItems"];

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
    // final snackBar = SnackBar(
    //   content: Text('Item removed from Cart'),
    //   backgroundColor: kPrimaryColor,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // list.add(SizedBox(width: getProportionateScreenWidth(20)));
  }

  @override
  void initState() {
    user_key = AuthProvider().user.uid;
    getVarientNumber(widget.cart.varientNumber, widget.cart.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int quantity = widget.cart.numOfItem;
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                  widget.cart.product.varients[selectedVarient].images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        // Expanded(
        //   child: Text(
        //     widget.cart.product.title,
        //     style: TextStyle(
        //         color: Colors.black,
        //         fontSize: getProportionateScreenHeight(20)),
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 2,
        //   ),
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(235),
              child: Text(
                widget.cart.product.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(20)),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Text(
              "Delivered",
              style: TextStyle(
                  fontSize: getProportionateScreenHeight(14)),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),

          ],
        )
      ],
    );
  }
}
