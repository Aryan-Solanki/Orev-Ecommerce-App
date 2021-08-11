import 'package:flutter/material.dart';
import 'package:orev/components/rounded_icon_btn.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/details/details_screen.dart';
import 'package:orev/services/product_services.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key key,
    @required this.cart,
    @required this.notifyParent,
  }) : super(key: key);

  final Cart cart;
  final Function() notifyParent;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: ProductDetailsArguments(product: widget.cart.product),
      ),
      child: Column(
        children: [
          Row(
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
                    child: Image.network(widget
                        .cart.product.varients[selectedVarient].images[0]),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cart.product.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(20)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 3),
                    Text(
                      "${widget.cart.product.varients[selectedVarient].title}",
                      style:
                          TextStyle(fontSize: getProportionateScreenHeight(15)),
                    ),
                    Text.rich(
                      TextSpan(
                        text:
                            "\₹${widget.cart.product.varients[selectedVarient].price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(20)),
                        children: [
                          TextSpan(
                              text: " x${quantity}",
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenWidth(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RoundedIconBtn(
                    width: 23.0,
                    height: 23.0,
                    colour: Color(0xFFB0B0B0).withOpacity(0.2),
                    icon: Icons.remove,
                    press: () {
                      if (quantity != 1) {
                        setState(() {
                          --quantity;
                          changeCartQty(quantity);
                        });
                      } else if (quantity == 1) {
                        removeFromCart(widget.cart.varientNumber);
                      }
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(7)),
                  Text(
                    "x" + quantity.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(20)),
                  ),
                  SizedBox(width: getProportionateScreenWidth(7)),
                  RoundedIconBtn(
                    width: 23.0,
                    height: 23.0,
                    colour: Color(0xFFB0B0B0).withOpacity(0.2),
                    icon: Icons.add,
                    showShadow: true,
                    press: () {
                      setState(() {
                        ++quantity;
                        changeCartQty(quantity);
                      });
                    },
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  text:
                      "\₹${widget.cart.product.varients[selectedVarient].price * quantity}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenHeight(20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
