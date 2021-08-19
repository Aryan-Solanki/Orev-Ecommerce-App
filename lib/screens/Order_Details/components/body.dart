import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/screens/Order_Details/components/price_cart.dart';
import 'package:orev/screens/your_order/your_order.dart';
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
  }) : super(key: key);

  final Product product;
  final int currentVarient;
  final int quantity;
  final double totalCost;
  final double deliveryCost;
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
        setState(() {
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
              if (payment_response == "TXN_FAILURE") {
                print("Transaction Failed");
                print(value['response']['RESPMSG']);
              } else if (payment_response == "TXN_SUCCESS") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => YourOrder()));
                print("Transaction Successful");
                print(value['response']['RESPMSG']);
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
