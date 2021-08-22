import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/models/Order.dart';
import 'package:orev/models/OrderProduct.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/screens/Order_Details/components/price_cart.dart';
import 'package:orev/screens/payment_success/payment_success.dart';
import 'package:orev/screens/your_order/your_order.dart';
import 'package:orev/services/order_services.dart';
import 'package:orev/services/user_services.dart';
import 'package:orev/services/user_simple_preferences.dart';
import 'package:paytm/paytm.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'order_info.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.product,
    @required this.currentVarient,
    @required this.quantity,
    @required this.selectedaddress,
    @required this.totalCost,
    @required this.deliveryCost,
    @required this.newwalletbalance,
    @required this.oldwalletbalance,
    @required this.codSellerCharge,
    @required this.orevWalletMoneyUsed,
    @required this.usedOrevWallet,
  }) : super(key: key);

  final Product product;
  final int currentVarient;
  final int quantity;
  final double totalCost;
  final double deliveryCost;
  final double newwalletbalance;
  final double oldwalletbalance;
  final bool usedOrevWallet;
  final double codSellerCharge;
  final double orevWalletMoneyUsed;
  final Map<String, dynamic> selectedaddress;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String payment_response;

  String mid = "LsrZNj54827134067770";
  String PAYTM_MERCHANT_KEY = "eMQRe_MdiSf0cuih";
  String website = "DEFAULT";
  bool testing = false;
  bool loading = false;

  void generateTxnToken() async {
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
    //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": mid,
      "key_secret": PAYTM_MERCHANT_KEY,
      "website": website,
      "orderId": orderId,
      // "amount": (widget.product.varients[widget.currentVarient].price * widget.quantity)
      //     .toString(),
      "amount": "1",
      "callbackUrl": callBackUrl,
      "custId": "122",
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
      });

      var paytmResponse = Paytm.payWithPaytm(
          mid,
          orderId,
          txnToken,
          // (widget.product.varients[widget.currentVarient].price *
          //         widget.quantity)
          //     .toString(),
          "1",
          callBackUrl,
          testing);

      paytmResponse.then((value) {
        print(value);
        setState(() async {
          loading = false;
          print("Value is ");
          print(value);
          if (value['error']) {
            payment_response = value['errorMessage'];
          } else {
            if (value['response'] != null) {
              payment_response = value['response']['STATUS'];
              print(
                  "Response                                           STATUS   ${value['response']['STATUS']}");
              String authkey = UserSimplePreferences.getAuthKey() ?? "";
              if (authkey == "") {
                print("Some error occured");
              }

              updateWalletBalance(newwalletbalance, orderId, timestamp) async {
                newwalletbalance = newwalletbalance.toDouble();
                UserServices _service = new UserServices();
                var user = await _service.getUserById(authkey);
                var transactionsList = user["walletTransactions"];
                transactionsList.add({
                  "newWalletBalance": newwalletbalance,
                  "oldWalletBalance": widget.oldwalletbalance,
                  "orderId": orderId,
                  "timestamp": timestamp
                });
                var values = {
                  "id": authkey,
                  "walletAmt": newwalletbalance,
                  "walletTransactions": transactionsList
                };
                _service.updateUserData(values);
              }

              Order order = Order(
                  cod: false,
                  deliveryBoy: "",
                  deliveryCost: widget.deliveryCost,
                  orderStatus: "Ordered",
                  product: new OrderProduct(
                      brandname: widget.product.brandname,
                      id: widget.product.id,
                      sellerId: widget.product.sellerId,
                      title: widget.product.title,
                      detail: widget.product.detail,
                      variant: widget.product.varients[widget.currentVarient],
                      tax: widget.product.tax),
                  orderId: orderId,
                  totalCost: widget.totalCost,
                  userId: authkey,
                  timestamp: DateTime.now().toString(),
                  selectedAddress: widget.selectedaddress,
                  responseMsg: value['response']['RESPMSG'],
                  codcharges: widget.codSellerCharge,
                  usedOrevWallet: widget.usedOrevWallet,
                  orevWalletAmountUsed: widget.orevWalletMoneyUsed);
              if (payment_response == "TXN_FAILURE") {
                Navigator.push(
                    context,
                    (MaterialPageRoute(
                        builder: (context) => PaymentSuccess(
                              transaction_success: false,
                              order: order,
                            ))));
                print("Transaction Failed");
                print(value['response']['RESPMSG']);
              } else if (payment_response == "TXN_SUCCESS") {
                print("Transaction Successful");
                print(value['response']['RESPMSG']);

                var values = {
                  "cod": order.cod,
                  "deliveryBoy": order.deliveryBoy,
                  "deliveryCost": order.deliveryCost,
                  "orderStatus": order.orderStatus,
                  "product": {
                    "brandname": order.product.brandname,
                    "id": order.product.id,
                    "sellerId": order.product.sellerId,
                    "title": order.product.title,
                    "detail": order.product.detail,
                    "variant": {
                      "title": order.product.variant.title,
                      "default": order.product.variant.default_product,
                      "id": order.product.variant.id,
                      "onSale": {
                        "comparedPrice": order.product.variant.comparedPrice,
                        "discountPercentage":
                            order.product.variant.discountPercentage,
                        "isOnSale": order.product.variant.isOnSale,
                      },
                      "price": order.product.variant.price,
                      "stock": {
                        "inStock": order.product.variant.inStock,
                        "qty": order.product.variant.qty
                      },
                      "variantDetails": {
                        "images": order.product.variant.images,
                        "title": order.product.variant.title,
                      },
                    },
                    "tax": order.product.tax,
                  },
                  "orderId": order.orderId,
                  "totalCost": order.totalCost,
                  "userId": order.userId,
                  "timestamp": order.timestamp,
                  "responseMsg": order.responseMsg,
                  "address": {
                    "name": widget.selectedaddress["name"],
                    "adline1": widget.selectedaddress["adline1"],
                    "adline2": widget.selectedaddress["adline2"],
                    "city": widget.selectedaddress["city"],
                    "state": widget.selectedaddress["state"],
                    "pincode": widget.selectedaddress["pincode"],
                  },
                  "codcharges": order.codcharges,
                  "usedOrevWallet": order.usedOrevWallet,
                  "orevWalletAmountUsed": order.orevWalletAmountUsed,
                };
                OrderServices _services = new OrderServices();
                try {
                  await _services.addOrder(values, order.orderId);
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: e.toString(),
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 2,
                      gravity: ToastGravity.BOTTOM);
                }

                updateWalletBalance(
                    widget.newwalletbalance, orderId, order.timestamp);

                Fluttertoast.showToast(
                    msg: "Order Placed",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 2,
                    gravity: ToastGravity.BOTTOM);
                Navigator.push(
                    context,
                    (MaterialPageRoute(
                        builder: (context) => PaymentSuccess(
                              transaction_success: true,
                              order: order,
                              cod: false,
                            ))));
              }
            }
          }
          payment_response += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          TotalPrice(
              key: UniqueKey(),
              product: widget.product,
              currentVarient: widget.currentVarient,
              quantity: widget.quantity,
              totalCost: widget.totalCost,
              deliveryCost: widget.deliveryCost),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          OrderInfo(
            key: UniqueKey(),
            product: widget.product,
            currentVarient: widget.currentVarient,
            quantity: widget.quantity,
            selectedaddress: widget.selectedaddress,
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                  "By placing your order, you agree to Orev's privacy notice and conditions of use.")),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                  "If you choose to pay using an electronic payment method (credit card or debit card), you will be directed to your bank's website to complete your payment. Your contract to purchase an item will not be complete until we receive your electronic payment and dispatch your item. If you choose to pay using Pay on Delivery (POD), you can pay using cash/card/net banking when you receive your item.")),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
            color: kPrimaryColor2,
            text: "Place Order",
            press: () {
              generateTxnToken();
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
        ],
      ),
    );
  }
}
