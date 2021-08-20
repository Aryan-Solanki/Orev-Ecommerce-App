import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
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
import 'package:orev/screens/home/components/home_header.dart';
import 'package:orev/screens/liked_item/like_screen.dart';
import 'package:orev/screens/seemore/seemore.dart';
import 'package:orev/screens/sign_in/sign_in_screen.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_services.dart';
import 'package:orev/services/user_simple_preferences.dart';
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
  final int varientNumberCart;
  const Body({Key key, @required this.product, this.varientNumberCart})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> foodVariantsTitles = [];
  List<Varient> foodVariants = [];
  List<Product> youMayAlsoLikeList = [];
  int selectedFoodVariants = 0;
  bool orevwallet = false;
  String soldby = "";
  bool L_loading = false;

  void getVarientList() {
    for (var title in widget.product.varients) {
      foodVariantsTitles.add(title.title);
      foodVariants.add(title);
    }
  }

  void getDefaultVarient() {
    if (widget.varientNumberCart != null) {
      selectedFoodVariants = widget.varientNumberCart;
    } else {
      int index = 0;
      for (var varient in widget.product.varients) {
        if (varient.default_product == true) {
          selectedFoodVariants = index;
          break;
        }
        index += 1;
      }
    }
  }

  Future<void> getYouMayAlsoLikeProductList() async {
    ProductServices _services = ProductServices();
    List<dynamic> ymalp = widget.product.youmayalsolike;
    for (var pr in ymalp) {
      youMayAlsoLikeList.add(await _services.getProduct(pr));
    }
    sellingdistance =
        await _services.getSellerSellingDistance(widget.product.sellerId);
    vendorlocation = await _services.getSellerLocation(widget.product.sellerId);
    deliveryCost =
        await _services.getSellerDeliveryCharge(widget.product.sellerId);
    deliveryCharge = deliveryCost["charge"].toDouble();
    freekms = deliveryCost["freeRadius"].toDouble();
    UserServices _services2 = UserServices();
    var result = await _services2.getUserById(user_key);
    walletbalance = result["walletAmt"].toDouble();
    L_loading = true;
    setState(() {});
  }

  Future<void> getWalletBalance() async {
    UserServices _services = UserServices();
    var result = await _services.getUserById(user_key);
    walletbalance = result["walletAmt"].toDouble();
    setState(() {});
  }

  String user_key;

  String authkey = '';

  @override
  void initState() {
    firstTime = true;
    authkey = UserSimplePreferences.getAuthKey() ?? '';
    getVarientList();
    getDefaultVarient();
    if (authkey != "") {
      user_key = AuthProvider().user.uid;
    }
    getYouMayAlsoLikeProductList();
    super.initState();
  }

  int quantity = 1;
  Map<String, dynamic> SelectedAddress;
  int _radioSelected = 0;
  String coupon = "";
  int coupon_value = 100;
  bool deliverable = true;
  bool firstTime = false;
  double sellingdistance = 0.0;
  double walletbalance = 0.0;
  double newwalletbalance = 0.0;
  GeoPoint vendorlocation;
  Map deliveryCost;
  double freekms = 0.0;
  double deliveryCharge = 0.0;

  @override
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

  @override
  Widget build(BuildContext context) {
    // showLoading(boo) {
    //   if (boo) {
    //     CoolAlert.show(
    //       context: context,
    //       type: CoolAlertType.loading,
    //       text: "Loading",
    //     );
    //   } else {}
    // }
    //
    // showLoading(true);

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
                          height: getProportionateScreenHeight(80),
                          width: getProportionateScreenWidth(80),
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
                                    fontSize: getProportionateScreenWidth(15)),
                              ),
                              Text(
                                "Sold by $soldby",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(13)),
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
                                  fontSize: getProportionateScreenWidth(16)),
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
                                    fontSize: getProportionateScreenWidth(16)),
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
                                    fontSize: getProportionateScreenWidth(14)),
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
                                  fontSize: getProportionateScreenWidth(16)),
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(20),
                        ),
                        Text(
                          "Cash on Delivery (COD)",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(16)),
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
                                  fontSize: getProportionateScreenWidth(16)),
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
                                    fontSize: getProportionateScreenWidth(16)),
                              ),
                              Text(
                                "(includes tax + Delivery: \₹$deliveryCharge)",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14)),
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
                      height: getProportionateScreenHeight(70),
                      child: Text(
                        "Swipe to place your order",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(12),
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
                          TextStyle(fontSize: getProportionateScreenWidth(12)),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                  ],
                ),
              ),
            ),
          ));
    }

    List<dynamic> addressmap = [];

    double totalCost = 0.0;
    double finalDeliveryCost = 0.0;

    // updateTotalCost(walletBalance) {
    //     totalCost = totalCost - walletbalance;
    // }

    Future<double> getFinalCost(SelectedAddress, boo) async {
      List<Location> locations =
          await locationFromAddress(SelectedAddress["pincode"].toString());
      var distanceInMeters = await Geolocator.distanceBetween(
        locations[0].latitude,
        locations[0].longitude,
        vendorlocation.latitude,
        vendorlocation.longitude,
      );
      if (distanceInMeters / 1000 > freekms) {
        totalCost =
            widget.product.varients[selectedFoodVariants].price * quantity +
                deliveryCharge;
        finalDeliveryCost = deliveryCharge;
      } else {
        totalCost =
            widget.product.varients[selectedFoodVariants].price * quantity;
        finalDeliveryCost = 0.0;
      }

      if (boo) {
        setState(() {});
      }
    }

    Future<void> getAllAddress() async {
      ProductServices _services = ProductServices();
      var userref = await _services.users.doc(user_key).get();
      addressmap = userref["address"];

      if (firstTime) {
        SelectedAddress = addressmap[0];

        List<Location> locations =
            await locationFromAddress(addressmap[0]["pincode"].toString());
        var distanceInMeters = await Geolocator.distanceBetween(
          locations[0].latitude,
          locations[0].longitude,
          vendorlocation.latitude,
          vendorlocation.longitude,
        );
        if ((distanceInMeters / 1000) < sellingdistance) {
          deliverable = true;
        } else {
          deliverable = false;
        }
        for (var maps in addressmap) {
          List<Location> locations =
              await locationFromAddress(maps["pincode"].toString());
          var distanceInMeters = await Geolocator.distanceBetween(
            locations[0].latitude,
            locations[0].longitude,
            vendorlocation.latitude,
            vendorlocation.longitude,
          );
          maps["distanceInMeters"] = distanceInMeters;
        }

        getFinalCost(SelectedAddress, false);

        firstTime = false;
      }
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

    getFinalCost(SelectedAddress, false);

    void _showDialog() {
      getFinalCost(SelectedAddress, false);
      slideDialog.showSlideDialog(
        context: context,
        barrierDismissible: false,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            firstTime = true;
            setState(() {});
            return true;
          },
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
                        builder: (BuildContext context, StateSetter setState) {
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
                                      onTap: () async {
                                        var distanceInMeters =
                                            addressmap[i]["distanceInMeters"];

                                        if ((distanceInMeters / 1000) <
                                            sellingdistance) {
                                          deliverable = true;
                                        } else {
                                          deliverable = false;
                                        }
                                        _radioSelected = i;
                                        SelectedAddress = addressmap[i];
                                        await getFinalCost(
                                            SelectedAddress, true);
                                        setState(() {});
                                      },
                                      child: Container(
                                          width:
                                              getProportionateScreenWidth(200),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 13),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  addressmap[i]["name"],
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              18),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        15),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      addressmap[i]["adline1"],
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  14),
                                                          color: Colors.black),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              3),
                                                    ),
                                                    Text(
                                                      addressmap[i]["adline2"],
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  14),
                                                          color: Colors.black),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              3),
                                                    ),
                                                    Text(
                                                      addressmap[i]["city"] +
                                                          " ," +
                                                          addressmap[i]
                                                              ["state"],
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  14),
                                                          color: Colors.black),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              3),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              StatefulBuilder(
                                  builder: (BuildContext context, setState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          _navigateAndDisplaySelection(context);
                                        },
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "Add New Address",
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        13),
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ),
                                      ),
                                    ),
                                    coupon == "aryan"
                                        ? Text(
                                            "You saved \₹$coupon_value",
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      13),
                                            ),
                                          )
                                        : coupon == ""
                                            ? Text("",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          13),
                                                ))
                                            : Text("Invalid Coupon",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          13),
                                                )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Use Orev Wallet",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              13)),
                                                ),
                                                Transform.scale(
                                                  scale:
                                                      getProportionateScreenHeight(
                                                          1),
                                                  child: Checkbox(
                                                    activeColor: kPrimaryColor,
                                                    value: orevwallet,
                                                    onChanged: (bool newValue) {
                                                      setState(() {
                                                        orevwallet = newValue;
                                                        SelectedAddress =
                                                            addressmap[
                                                                _radioSelected];
                                                        getFinalCost(
                                                            SelectedAddress,
                                                            false);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            orevwallet == false
                                                ? Text(
                                                    "Balance: ₹$walletbalance",
                                                    style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                12),
                                                        color: kPrimaryColor),
                                                  )
                                                : Text(
                                                    totalCost >= walletbalance
                                                        ? "Balance: ₹${newwalletbalance = 0.0}"
                                                        : "Balance: ₹${newwalletbalance = (walletbalance - (totalCost))}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                12),
                                                        color: kPrimaryColor),
                                                  ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                30),
                                                      ),
                                                      Container(
                                                          child: Text(
                                                        "Total",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    23)),
                                                      )),
                                                      SizedBox(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                20),
                                                      ),
                                                      orevwallet == false
                                                          ? Text(
                                                              "\₹${totalCost}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      getProportionateScreenHeight(
                                                                          20)),
                                                            )
                                                          : Text(
                                                              totalCost >
                                                                      walletbalance
                                                                  ? "\₹${totalCost = ((totalCost) - walletbalance)}"
                                                                  : "\₹${totalCost = 0.0}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      getProportionateScreenHeight(
                                                                          20)),
                                                            ),
                                                    ],
                                                  ),
                                                  orevwallet == false
                                                      ? Column(
                                                          children: [
                                                            Text(
                                                              "       (includes tax + Delivery: \₹$finalDeliveryCost)",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      getProportionateScreenWidth(
                                                                          13)),
                                                            )
                                                          ],
                                                        )
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "       (includes tax + Delivery: \₹$finalDeliveryCost)",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      getProportionateScreenWidth(
                                                                          13)),
                                                            ),
                                                            Text(
                                                              totalCost >=
                                                                      newwalletbalance
                                                                  ? "( - Orev Wallet: ${walletbalance - newwalletbalance})"
                                                                  : "( - Orev Wallet: ${walletbalance - newwalletbalance})",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      getProportionateScreenWidth(
                                                                          13)),
                                                            )
                                                          ],
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(20),
                                    ),
                                    deliverable == true
                                        ? Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        13),
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        : Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "This product is not availabe in the selected location\n",
                                              style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        13),
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                    deliverable == true
                                        ? DefaultButton(
                                            textheight: 15,
                                            colour: Colors.white,
                                            height: 70,
                                            color: kPrimaryColor2,
                                            text: orevwallet == true
                                                ? totalCost == 0.0
                                                    ? "Place Order"
                                                    : "Cash on Delivery (COD)"
                                                : "Cash on Delivery (COD)",
                                            press: () {
                                              Navigator.pop(context);
                                              _showCODDialog();
                                            },
                                          )
                                        : DefaultButton(
                                            textheight: 15,
                                            colour: Colors.white,
                                            height: 70,
                                            color: kSecondaryColor,
                                            text: "Cash on Delivery (COD)",
                                            press: () {},
                                          ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(10),
                                    ),
                                    deliverable == true
                                        ? orevwallet == true
                                            ? totalCost == 0.0
                                                ? Center()
                                                : DefaultButton(
                                                    textheight: 15,
                                                    colour: Colors.white,
                                                    height: 70,
                                                    color: kPrimaryColor,
                                                    text: "Pay Online",
                                                    press: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OrderDetails(
                                                                  key:
                                                                      UniqueKey(),
                                                                  product: widget
                                                                      .product,
                                                                  currentVarient:
                                                                      selectedFoodVariants,
                                                                  quantity:
                                                                      quantity,
                                                                  selectedaddress:
                                                                      SelectedAddress,
                                                                  totalCost:
                                                                      totalCost,
                                                                  deliveryCost:
                                                                      finalDeliveryCost,
                                                                )),
                                                      );
                                                    },
                                                  )
                                            : DefaultButton(
                                                textheight: 15,
                                                colour: Colors.white,
                                                height: 70,
                                                color: kPrimaryColor,
                                                text: "Pay Online",
                                                press: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderDetails(
                                                              key: UniqueKey(),
                                                              product: widget
                                                                  .product,
                                                              currentVarient:
                                                                  selectedFoodVariants,
                                                              quantity:
                                                                  quantity,
                                                              selectedaddress:
                                                                  SelectedAddress,
                                                              totalCost:
                                                                  totalCost,
                                                              deliveryCost:
                                                                  finalDeliveryCost,
                                                            )),
                                                  );
                                                })
                                        : DefaultButton(
                                            textheight: 15,
                                            // colour: Colors.white,
                                            height: 70,
                                            color: kSecondaryColor,
                                            text: "Pay Online",
                                            press: () {},
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
          }),
        ),
      );
    }

    List<dynamic> keys = [];

    Future<void> addToCart() async {
      ProductServices _services = ProductServices();
      var favref = await _services.cart.doc(user_key).get();
      keys = favref["cartItems"];

      var x = widget.product.varients[selectedFoodVariants].id;

      bool alreadyexixts = false;

      for (var k in keys) {
        if (k["varientNumber"] == x && k["productId"] == widget.product.id) {
          var currentqty = k["qty"];
          var newqty = currentqty + quantity;
          k["qty"] = newqty;
          alreadyexixts = true;
        }
      }
      if (!alreadyexixts) {
        keys.add({
          "productId": widget.product.id,
          "qty": quantity,
          "varientNumber": x,
        });
      }

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
        return Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(10)),
            Expanded(
              child: DirectSelectContainer(
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
                                                      getDropDownMenuItem(
                                                          value),
                                                  focusedItemDecoration:
                                                      getDslDecoration(),
                                                  onItemSelectedListener:
                                                      (item, index, context) {
                                                    selectedFoodVariants =
                                                        index;
                                                    setState(() {});
                                                  })),
                                          // SizedBox(width: getProportionateScreenWidth(100),),
                                          Icon(
                                            Icons.unfold_more,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(15),
                                          ),
                                          RoundedIconBtn(
                                            icon: Icons.remove,
                                            press: () {
                                              if (quantity != 1) {
                                                setState(() {
                                                  quantity--;
                                                  getFinalCost(
                                                      SelectedAddress, false);
                                                });
                                              }
                                            },
                                          ),
                                          SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      20)),
                                          Text(
                                            "x " + quantity.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        20)),
                                          ),
                                          SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      20)),
                                          RoundedIconBtn(
                                            icon: Icons.add,
                                            showShadow: true,
                                            press: () {
                                              setState(() {
                                                quantity++;
                                                getFinalCost(
                                                    SelectedAddress, false);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    !widget
                                                .product
                                                .varients[selectedFoodVariants]
                                                .inStock ==
                                            false
                                        ? L_loading
                                            ? TopRoundedContainer(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.1,
                                                    right:
                                                        SizeConfig.screenWidth *
                                                            0.1,
                                                    bottom:
                                                        getProportionateScreenWidth(
                                                            30),
                                                    top:
                                                        getProportionateScreenWidth(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      DefaultButton(
                                                        color: kPrimaryColor2,
                                                        text: "Buy Now",
                                                        press: () {
                                                          setState(() {});
                                                          if (authkey == '') {
                                                            Navigator.pushNamed(
                                                                context,
                                                                SignInScreen
                                                                    .routeName);
                                                          } else {
                                                            if (addressmap
                                                                .isEmpty) {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  Address
                                                                      .routeName);
                                                            } else {
                                                              _showDialog();
                                                            }
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
                                                          if (authkey == '') {
                                                            Navigator.pushNamed(
                                                                context,
                                                                SignInScreen
                                                                    .routeName);
                                                          } else {
                                                            addToCart();
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Center()
                                        : TopRoundedContainer(
                                            color: Colors.white,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: SizeConfig.screenWidth *
                                                      0.1,
                                                  right:
                                                      SizeConfig.screenWidth *
                                                          0.1,
                                                  bottom:
                                                      getProportionateScreenWidth(
                                                          30),
                                                  top:
                                                      getProportionateScreenWidth(
                                                          10),
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
                                            if (youMayAlsoLikeList.length ==
                                                0) {
                                              return SizedBox.shrink();
                                            } else {
                                              return ProductCard(
                                                  product: youMayAlsoLikeList[
                                                      index]);
                                            }
                                            // here by default width and height is 0
                                          },
                                        ),
                                        SizedBox(
                                            width: getProportionateScreenWidth(
                                                20)),
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
              ),
            ),
          ],
        );
      },
    );
  }
}
