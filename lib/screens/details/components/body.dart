import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/components/rounded_icon_btn.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/Order_Details/order_details.dart';
import 'package:orev/screens/address/address.dart';
import 'package:orev/screens/liked_item/like_screen.dart';
import 'package:orev/screens/seemore/seemore.dart';
import 'package:orev/screens/sign_in/sign_in_screen.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/size_config.dart';
import 'package:paytm/paytm.dart';
import 'package:search_choices/search_choices.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class Body extends StatefulWidget {
  final Product product;
  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> foodVariantsTitles = [];
  List<Varient> foodVariants = [];
  List<Product> youMayAlsoLikeList = [];
  int selectedFoodVariants = 0;
  bool orevwallet=false;
  String soldby = "Aryan Tatva Sellers";

  void getVarientList() {
    for (var title in widget.product.varients) {
      foodVariantsTitles.add(title.title);
      foodVariants.add(title);
    }
  }

  void getDefaultVarient() {
    int index = 0;
    for (var varient in widget.product.varients) {
      if (varient.default_product == true) {
        selectedFoodVariants = index;
        break;
      }
      index += 1;
    }
  }

  Future<void> getYouMayAlsoLikeProductList() async {
    ProductServices _services = ProductServices();
    List<dynamic> ymalp = widget.product.youmayalsolike;
    for (var pr in ymalp) {
      youMayAlsoLikeList.add(await _services.getProduct(pr));
    }
    setState(() {});
  }

  // List<dynamic> addressmap = [];
  String user_key;

  // Future<void> getAllAddress() async {
  //   ProductServices _services = ProductServices();
  //   print(user_key);
  //   var userref = await _services.users.doc(user_key).get();
  //   addressmap = userref["address"];
  // }

  @override
  void initState() {
    super.initState();
    getVarientList();
    getDefaultVarient();
    user_key = AuthProvider().user.uid;
    getYouMayAlsoLikeProductList();
    // getAllAddress();
    super.initState();
  }

  @override
  int quantity = 1;
  Map<String, dynamic> SelectedAddress;
  int _radioSelected = 0;
  String coupon = "";
  int coupon_value = 100;
  bool deliverable=true;
  double sellingdistance=20;
  double walletbalance=0.0;
  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(
            value,
            style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(18)),
          );
        });
  }

  getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }
  // void _showScaffold() {
  //   final snackBar = SnackBar(content: Text('Hold and drag instead of tap'));
  //   scaffoldKey.currentState?.showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    void _showCODDialog() {
      slideDialog.showSlideDialog(
          context: context,
          child: Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(100),
                          width: getProportionateScreenWidth(100),
                          child: Image.network(widget.product
                              .varients[selectedFoodVariants].images[0]),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionateScreenHeight(18)),
                              ),
                              Text(
                                "Sold by $soldby",
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(15)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Container(
                            width: getProportionateScreenWidth(90),
                            child: Text(
                              "Deliver to",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: getProportionateScreenHeight(23)),
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SelectedAddress["name"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenHeight(20)),
                              ),
                              Text(
                                SelectedAddress["adline1"] +
                                    " " +
                                    SelectedAddress["adline2"] +
                                    " " +
                                    SelectedAddress["city"] +
                                    " " +
                                    SelectedAddress["state"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(18)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Container(
                            width: getProportionateScreenWidth(90),
                            child: Text(
                              "Pay with",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: getProportionateScreenHeight(23)),
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(
                          "Cash on Delivery (COD)",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(20)),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Container(
                            width: getProportionateScreenWidth(90),
                            child: Text(
                              "Total",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: getProportionateScreenHeight(23)),
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\₹${widget.product.varients[selectedFoodVariants].price * quantity}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenHeight(20)),
                              ),
                              Text(
                                "(includes tax + Delivery: \₹50)",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(18)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(35)),
                    SwipeButton(
                      thumb: Icon(Icons.double_arrow_outlined),
                      activeThumbColor: kPrimaryColor4,
                      borderRadius: BorderRadius.circular(8),
                      activeTrackColor: kPrimaryColor3,
                      height: getProportionateScreenHeight(80),
                      child: Text(
                        "Swipe to place your order",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(13),
                        ),
                      ),
                      onSwipe: () {
                        print("Order Placed");
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      "By placing your order, you agree to Orev's privacy notice and conditions of use.",
                      style:
                          TextStyle(fontSize: getProportionateScreenHeight(16)),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                  ],
                ),
              ),
            ),
          ));
    }

    List<dynamic> addressmap = [];

    Future<void> getAllAddress() async {
      ProductServices _services = ProductServices();
      print(user_key);
      var userref = await _services.users.doc(user_key).get();
      addressmap = userref["address"];
      SelectedAddress = addressmap[0];
    }

    _navigateAndDisplaySelection(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Address()),
      );

      if (result) {
        setState(() {
          Navigator.pop(context);
          final snackBar = SnackBar(
            content: Text('Address Added Successfully'),
            backgroundColor: kPrimaryColor,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    }

    getAllAddress();
    void _showDialog() {
      slideDialog.showSlideDialog(
          context: context,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Choose your location",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(23),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Choose a delivery address for your product..",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Color(0xff565656),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setState) {
                          return Column(
                            children: [
                              Container(
                                height: getProportionateScreenHeight(180),
                                child: ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: addressmap.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () async{
                                        List<Location> locations = await locationFromAddress(addressmap[i]["pincode"].toString());
                                        var distanceInMeters = await Geolocator.distanceBetween(
                                          locations[0].latitude,
                                          locations[0].longitude,
                                          28.5320,
                                          77.2959,
                                        );
                                        print(distanceInMeters);
                                        if((distanceInMeters/1000)<sellingdistance){
                                          deliverable=true;
                                        }
                                        else{
                                          deliverable=false;
                                        }
                                        _radioSelected = i;
                                        setState(() {
                                          SelectedAddress = addressmap[i];
                                          // print(SelectedAddress);
                                        });
                                      },
                                      child: Container(
                                          width: 200,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 13),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: _radioSelected == i
                                                  ? kPrimaryColor2
                                                  : Color(0xff565656),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    addressmap[i]["name"],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                        getProportionateScreenHeight(
                                                            23),
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  addressmap[i]["adline1"],
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  addressmap[i]["adline2"],
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  addressmap[i]["city"] +
                                                      " ," +
                                                      addressmap[i]["state"],
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(10)),
                              StatefulBuilder(
                                  builder: (BuildContext context, setState) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
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
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.lightGreen,
                                                            width: 1.0),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.lightGreen,
                                                            width: 2.0),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: getProportionateScreenWidth(10),
                                                ),
                                                Container(
                                                  width: getProportionateScreenWidth(50),
                                                  child: FlatButton(
                                                      color: Colors.lightGreen,
                                                      onPressed: () {
                                                        setState(() {
                                                          print(coupon);
                                                        });
                                                      },
                                                      child: Text(
                                                        "Add",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                            getProportionateScreenWidth(
                                                                10)),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                _navigateAndDisplaySelection(context);
                                              },
                                              child: Text(
                                                "Add New Address",
                                                style: TextStyle(
                                                    decoration: TextDecoration.underline),
                                              ),
                                            ),
                                          ],
                                        ),
                                        coupon == "aryan"
                                            ? Text("  You saved \₹$coupon_value")
                                            : coupon == ""
                                            ? Text("")
                                            : Text("Invalid Coupon"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Use Orev Wallet",style: TextStyle(fontSize: getProportionateScreenWidth(13)),),
                                                    Checkbox(
                                                      value: orevwallet,
                                                      onChanged: (bool newValue) {
                                                        setState(() {
                                                          orevwallet = newValue;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                orevwallet==false?Text("Balance: ₹$walletbalance",style: TextStyle(fontSize: getProportionateScreenWidth(12),color: kPrimaryColor),):Text((widget.product.varients[selectedFoodVariants].price * quantity)>=walletbalance?"Balance: ₹0.0":"Balance: ₹${walletbalance-(widget.product.varients[selectedFoodVariants].price * quantity)}",style: TextStyle(fontSize: getProportionateScreenWidth(12),color: kPrimaryColor),),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                        width: getProportionateScreenWidth(90),
                                                        child: Text(
                                                          "Total",
                                                          style: TextStyle(
                                                              color: Colors.blue,
                                                              fontSize: getProportionateScreenHeight(23)),
                                                        )),
                                                    orevwallet==false?Text(
                                                      "\₹${widget.product.varients[selectedFoodVariants].price * quantity}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: getProportionateScreenHeight(20)),
                                                    ):Text(
                                                      (widget.product.varients[selectedFoodVariants].price * quantity)>walletbalance?"\₹${(widget.product.varients[selectedFoodVariants].price * quantity)-walletbalance}":"\₹0.0",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: getProportionateScreenHeight(20)),
                                                    ),
                                                  ],
                                                ),

                                                orevwallet==false?Column(
                                                  children: [
                                                    Text(
                                                      "(includes tax + Delivery: \₹50)",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: getProportionateScreenHeight(14)),
                                                    )
                                                  ],
                                                ):Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "(includes tax + Delivery: \₹50)",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: getProportionateScreenHeight(14)),
                                                    ),
                                                    Text(
                                                      (widget.product.varients[selectedFoodVariants].price * quantity)>=walletbalance? "( - Orev Wallet: $walletbalance)":"( - Orev Wallet: ${widget.product.varients[selectedFoodVariants].price * quantity})",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: getProportionateScreenHeight(14)),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        deliverable==true?Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                              fontSize: getProportionateScreenWidth(12),
                                              color: Colors.red,
                                            ),
                                          ),
                                        ):Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "No available seller in your location\n",
                                            style: TextStyle(
                                              fontSize: getProportionateScreenWidth(12),
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        deliverable==true?DefaultButton(
                                          textheight: 15,
                                          colour: Colors.white,
                                          height: 70,
                                          color: kPrimaryColor2,
                                          text: orevwallet==true?(widget.product.varients[selectedFoodVariants].price * quantity)<=walletbalance?"Place Order":"Cash on Delivery (COD)":"Cash on Delivery (COD)",
                                          press: () {
                                            Navigator.pop(context);
                                            _showCODDialog();
                                          },
                                        ):DefaultButton(
                                          textheight: 15,
                                          colour: Colors.white,
                                          height: 70,
                                          color: kSecondaryColor,
                                          text: "Cash on Delivery (COD)",
                                          press: () {
                                          },
                                        ),

                                        SizedBox(
                                          height: getProportionateScreenHeight(10),
                                        ),
                                        deliverable==true?orevwallet==true?(widget.product.varients[selectedFoodVariants].price * quantity)<=walletbalance?Center():DefaultButton(
                                          textheight: 15,
                                          colour: Colors.white,
                                          height: 70,
                                          color: kPrimaryColor,
                                          text: "Pay Online",
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => OrderDetails(
                                                key: UniqueKey(),
                                                product: widget.product,
                                                currentVarient: selectedFoodVariants,
                                                quantity: quantity,
                                                selectedaddress: SelectedAddress,
                                              )),
                                            );

                                          },
                                        ):DefaultButton(
                                          textheight: 15,
                                          colour: Colors.white,
                                          height: 70,
                                          color: kPrimaryColor,
                                          text: "Pay Online",
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => OrderDetails(
                                                key: UniqueKey(),
                                                product: widget.product,
                                                currentVarient: selectedFoodVariants,
                                                quantity: quantity,
                                                selectedaddress: SelectedAddress,
                                              )),
                                            );

                                          }
                                          ):DefaultButton(
                                          textheight: 15,
                                          // colour: Colors.white,
                                          height: 70,
                                          color: kSecondaryColor,
                                          text: "Pay Online",
                                          press: (){
                                          },
                                        ),


                                      ],
                                    );
                                  }),


                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }));
    }

    List<dynamic> keys = [];

    Future<void> addToCart() async {
      ProductServices _services = ProductServices();
      print(user_key);
      var favref = await _services.cart.doc(user_key).get();
      keys = favref["cartItems"];

      var x = widget.product.varients[selectedFoodVariants].id;
      print(x);

      keys.add({
        "productId": widget.product.id,
        "qty": quantity,
        "varientNumber": x,
      });
      await _services.cart.doc(user_key).update({'cartItems': keys});
      setState(() {
        final snackBar = SnackBar(
          content: Text('Item added to Cart'),
          backgroundColor: kPrimaryColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      // list.add(SizedBox(width: getProportionateScreenWidth(20)));
    }

    return StatefulBuilder(
      builder: (context, StateSetter setState) {
        return DirectSelectContainer(
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: kPrimaryColor2,
              child: ListView(
                children: [
                  ProductImages(
                      key: UniqueKey(),
                      product: widget.product,
                      currentVarient: selectedFoodVariants),
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ProductDescription(
                          key: UniqueKey(),
                          product: widget.product,
                          currentVarient: selectedFoodVariants,
                          quantity: quantity,
                        ),
                        TopRoundedContainer(
                          color: Color(0xFFF6F7F9),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  // mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                        child: DirectSelectList<String>(
                                            values: foodVariantsTitles,
                                            defaultItemIndex:
                                                selectedFoodVariants,
                                            itemBuilder: (String value) =>
                                                getDropDownMenuItem(value),
                                            focusedItemDecoration:
                                                getDslDecoration(),
                                            onItemSelectedListener:
                                                (item, index, context) {
                                              selectedFoodVariants = index;
                                              setState(() {
                                                print(selectedFoodVariants);
                                              });
                                              print(selectedFoodVariants);
                                            })),
                                    // SizedBox(width: getProportionateScreenWidth(100),),
                                    Icon(
                                      Icons.unfold_more,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(15),
                                    ),
                                    RoundedIconBtn(
                                      icon: Icons.remove,
                                      press: () {
                                        if (quantity != 1) {
                                          setState(() {
                                            quantity--;
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(
                                        width: getProportionateScreenWidth(20)),
                                    Text(
                                      "x " + quantity.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenHeight(20)),
                                    ),
                                    SizedBox(
                                        width: getProportionateScreenWidth(20)),
                                    RoundedIconBtn(
                                      icon: Icons.add,
                                      showShadow: true,
                                      press: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              !widget.product.varients[selectedFoodVariants]
                                          .inStock ==
                                      false
                                  ? TopRoundedContainer(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.1,
                                          right: SizeConfig.screenWidth * 0.1,
                                          bottom:
                                              getProportionateScreenWidth(30),
                                          top: getProportionateScreenWidth(10),
                                        ),
                                        child: Column(
                                          children: [
                                            DefaultButton(
                                              color: kPrimaryColor2,
                                              text: "Buy Now",
                                              press: () {
                                                setState(() {});
                                                if (addressmap.isEmpty) {
                                                  Navigator.pushNamed(context,
                                                      Address.routeName);
                                                } else {
                                                  _showDialog();
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      15),
                                            ),
                                            DefaultButton(
                                              text: "Add To Cart",
                                              press: () {
                                                addToCart();
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : TopRoundedContainer(
                                      color: Colors.white,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            left: SizeConfig.screenWidth * 0.1,
                                            right: SizeConfig.screenWidth * 0.1,
                                            bottom:
                                                getProportionateScreenWidth(30),
                                            top:
                                                getProportionateScreenWidth(10),
                                          ),
                                          child: DefaultButton(
                                            color: kSecondaryColor,
                                            text: "Out of Stock",
                                            press: () {},
                                          )),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(15),
                              bottom: getProportionateScreenWidth(5)),
                          child: Text(
                            "You Might Also Like",
                            style: smallerheadingStyle,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        ScrollConfiguration(
                          behavior: ScrollBehavior(),
                          child: GlowingOverscrollIndicator(
                            axisDirection: AxisDirection.right,
                            color: kPrimaryColor2,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    widget.product.youmayalsolike.length,
                                    (index) {
                                      if (youMayAlsoLikeList.length == 0) {
                                        return SizedBox.shrink();
                                      } else {
                                        return ProductCard(
                                            product: youMayAlsoLikeList[index]);
                                      }
                                      // here by default width and height is 0
                                    },
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(20)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
