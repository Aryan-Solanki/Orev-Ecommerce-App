import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Order.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../size_config.dart';

class YourOrderDetail extends StatefulWidget {
  final Order order;
  static String routeName = "/your_order_detail";
  YourOrderDetail({@required this.order});
  @override
  _YourOrderDetailState createState() => _YourOrderDetailState();
}

class _YourOrderDetailState extends State<YourOrderDetail> {
  @override
  static String routeName = "/your_order_detail";

  String username = "";
  String userphone = "";
  String sellername = "";

  Future<void> getUserInfo() async {
    UserServices _services = new UserServices();
    var user = await _services.getUserById(widget.order.userId);
    username = user["name"];
    userphone = user["number"];
    setState(() {});
  }

  Future<void> getSellerInfo() async {
    ProductServices _services = new ProductServices();
    sellername = await _services.getSellerInfo(widget.order.product.sellerId);
    setState(() {});
  }

  @override
  void initState() {
    getUserInfo();
    getSellerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _orderState = 0;
    final double _packedState = 10;
    final double _shippedState = 20;
    final double _deliveredState = 30;
    final Color _activeColor = kPrimaryColor;
    final Color _inactiveColor = kPrimaryColor;

    double _deliveryStatus = _orderState;

    if (widget.order.orderStatus == "Ordered") {
      _deliveryStatus = _orderState;
    } else if (widget.order.orderStatus == "Packed") {
      _deliveryStatus = _packedState;
    } else if (widget.order.orderStatus == "Shipped") {
      _deliveryStatus = _shippedState;
    } else if (widget.order.orderStatus == "Delivered") {
      _deliveryStatus = _deliveredState;
    }

    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.order.product.title}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          Text("${widget.order.product.variant.title}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12)))
                        ],
                      ),
                    ),
                    Container(
                      height: getProportionateScreenHeight(100),
                      width: getProportionateScreenWidth(100),
                      child: Image.network(
                          "${widget.order.product.variant.images[0]}"),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Text("Seller : $sellername",
                    style:
                        TextStyle(fontSize: getProportionateScreenWidth(12))),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Shipping Address",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black45, // red as border color
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.order.selectedAddress["name"]}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Text("${widget.order.selectedAddress["adline1"]}",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14))),
                            Text("${widget.order.selectedAddress["adline2"]}",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14))),
                            Text(
                                "${widget.order.selectedAddress["city"]}-${widget.order.selectedAddress["pincode"].toString()}",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14))),
                            Text("Phone number: $userphone",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14))),
                          ],
                        ),
                      ),
                      Container(
                          height: getProportionateScreenHeight(200),
                          child: SfLinearGauge(
                            orientation: LinearGaugeOrientation.vertical,
                            minimum: 0,
                            maximum: 30,
                            labelOffset: 24,
                            isAxisInversed: true,
                            showTicks: false,
                            onGenerateLabels: () {
                              return <LinearAxisLabel>[
                                const LinearAxisLabel(
                                    text: 'Ordered', value: 0),
                                const LinearAxisLabel(
                                    text: 'Packed', value: 10),
                                const LinearAxisLabel(
                                    text: 'Shipped', value: 20),
                                const LinearAxisLabel(
                                    text: 'Delivered', value: 30),
                              ];
                            },
                            axisTrackStyle: LinearAxisTrackStyle(
                              color: _activeColor,
                            ),
                            barPointers: <LinearBarPointer>[
                              LinearBarPointer(
                                value: _deliveryStatus,
                                color: _activeColor,
                                enableAnimation: false,
                                position: LinearElementPosition.cross,
                              ),
                            ],
                            markerPointers: <LinearMarkerPointer>[
                              LinearWidgetPointer(
                                value: _orderState,
                                enableAnimation: false,
                                position: LinearElementPosition.cross,
                                child: Container(
                                  width: getProportionateScreenWidth(14),
                                  height: getProportionateScreenWidth(14),
                                  decoration: BoxDecoration(
                                      color: _deliveryStatus > 0
                                          ? _activeColor
                                          : Colors.white,
                                      border: Border.all(
                                          width: 4, color: _activeColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                              ),
                              LinearWidgetPointer(
                                enableAnimation: false,
                                value: _packedState,
                                position: LinearElementPosition.cross,
                                child: Container(
                                  width: getProportionateScreenWidth(14),
                                  height: getProportionateScreenWidth(14),
                                  decoration: BoxDecoration(
                                      color: _deliveryStatus > 10
                                          ? _activeColor
                                          : Colors.white,
                                      border: Border.all(
                                          width: 4, color: _activeColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                              ),
                              LinearWidgetPointer(
                                value: _shippedState,
                                enableAnimation: false,
                                position: LinearElementPosition.cross,
                                child: Container(
                                  width: getProportionateScreenWidth(14),
                                  height: getProportionateScreenWidth(14),
                                  decoration: BoxDecoration(
                                      color: _deliveryStatus > 20
                                          ? _activeColor
                                          : Colors.white,
                                      border: Border.all(
                                          width: 4, color: _activeColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                              ),
                              LinearWidgetPointer(
                                value: _deliveredState,
                                enableAnimation: false,
                                position: LinearElementPosition.cross,
                                child: Container(
                                  width: getProportionateScreenWidth(14),
                                  height: getProportionateScreenWidth(14),
                                  decoration: BoxDecoration(
                                      color: _deliveryStatus > 30
                                          ? _activeColor
                                          : Colors.white,
                                      border: Border.all(
                                          width: 4, color: _activeColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                              ),
                              LinearShapePointer(
                                animationDuration: 2000,
                                value: _deliveryStatus,
                                enableAnimation: true,
                                color: _activeColor,
                                width: getProportionateScreenWidth(14),
                                height: getProportionateScreenWidth(14),
                                position: LinearElementPosition.cross,
                                shapeType: LinearShapePointerType.circle,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Divider(color: Colors.black),

                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Payment Information",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45, // red as border color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          widget.order.cod
                              ? "Online Payment"
                              : "Cash On Delivery",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black),
                        ),
                        Divider(color: Colors.black),
                        Text(
                          "Billing Address",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        Text("${widget.order.selectedAddress["adline1"]}",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black)),
                        Text("${widget.order.selectedAddress["adline2"]}",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black)),
                        Text(
                            "${widget.order.selectedAddress["city"]}-${widget.order.selectedAddress["pincode"].toString()}",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black)),
                        Text("Phone number: $userphone",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black)),
                      ],
                    )),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Divider(color: Colors.black),

                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Order Summary",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45, // red as border color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Cost:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(15)),
                            ),
                            Text("₹${widget.order.product.variant.price}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionateScreenWidth(15))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Postage & Packing:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(15)),
                            ),
                            Text("₹0.00",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionateScreenWidth(15))),
                          ],
                        ),
                        widget.order.usedOrevWallet
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Wallet Amount Used:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            getProportionateScreenWidth(15)),
                                  ),
                                  Text(
                                      " - ₹${widget.order.orevWalletAmountUsed}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenWidth(15))),
                                ],
                              )
                            : Center(),
                        widget.order.cod
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "COD Charges:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            getProportionateScreenWidth(15)),
                                  ),
                                  Text("₹${widget.order.codcharges}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenWidth(15))),
                                ],
                              )
                            : Center(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(15)),
                            ),
                            Text("₹${widget.order.totalCost}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionateScreenWidth(15))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Total:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("₹${widget.order.totalCost}",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(20),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                DefaultButton(
                  color: kPrimaryColor2,
                  text: "Download Invoice",
                  press: () {},
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                // Container(
                //   padding: EdgeInsets.only(bottom: 20),
                //   color: Colors.white,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.only(
                //             left: getProportionateScreenWidth(15),
                //             bottom: getProportionateScreenWidth(5)),
                //         child: Text(
                //           "You Might Also Like",
                //           style: smallerheadingStyle,
                //         ),
                //       ),
                //       SizedBox(
                //         height: getProportionateScreenHeight(10),
                //       ),
                //       ScrollConfiguration(
                //         behavior: ScrollBehavior(),
                //         child: GlowingOverscrollIndicator(
                //           axisDirection: AxisDirection.right,
                //           color: kPrimaryColor2,
                //           child: SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Row(
                //               children: [
                //                 ...List.generate(
                //                   widget.product.youmayalsolike.length,
                //                       (index) {
                //                     if (youMayAlsoLikeList.length == 0) {
                //                       return SizedBox.shrink();
                //                     } else {
                //                       return ProductCard(
                //                           product: youMayAlsoLikeList[index]);
                //                     }
                //                     // here by default width and height is 0
                //                   },
                //                 ),
                //                 SizedBox(
                //                     width: getProportionateScreenWidth(20)),
                //               ],
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Order Details",
            style: TextStyle(color: Colors.black),
          ),
          // Text(
          //   "${demoCarts.length} items",
          //   style: Theme.of(context).textTheme.caption,
          // ),
        ],
      ),
    );
  }
}
