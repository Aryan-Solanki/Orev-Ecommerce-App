import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/orevwallet_afterpage.dart';
import 'package:paytm/paytm.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../size_config.dart';


class Body extends StatefulWidget {
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
      "amount": amount,
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
          (amount),
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
            }
          }
          payment_response += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }


  String amount;

  Color ruppeecolor=Colors.black45;
  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      slideDialog.showSlideDialog(
          context: context,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Apply Coupon Code",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(25),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(50),),
                Theme(
                  data: Theme.of(context).copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      )
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: (){

                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: getProportionateScreenHeight(13)),
                              child: Text("Apply",style: TextStyle(fontSize: getProportionateScreenWidth(12),color: kPrimaryColor2,),
                              ),
                            )
                        ),
                        hintText: 'Enter Coupon Code',
                        hintStyle: TextStyle(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.bold,color: ruppeecolor),
                        contentPadding:EdgeInsets.only(bottom: getProportionateScreenHeight(13))
                    ),

                  ),
                ),

              ],
            ),
          ));
    }

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Orev Wallet",style: TextStyle(fontSize: getProportionateScreenWidth(25),fontWeight: FontWeight.bold,color: Colors.black),),
            Text("Available Orev Balance ₹289344.00",style: TextStyle(fontSize: getProportionateScreenWidth(15)),),
            SizedBox(height: getProportionateScreenHeight(50),),
            Text("Add Money",style: TextStyle(fontSize: getProportionateScreenWidth(18),color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(height: getProportionateScreenHeight(30),),
            Theme(
              data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                  )
              ),
              child: TextField(
                style: TextStyle(fontSize: getProportionateScreenWidth(30),fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  amount=value;
                  if(value==""){
                    setState(() {
                      ruppeecolor=Colors.black45;
                    });
                  }
                  if(value!="" && ruppeecolor==Colors.black45){
                    setState(() {
                      ruppeecolor=Colors.black;
                    });
                  }
                  print(value);
                },
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: (){
                          print("halua");
                          _showDialog();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: getProportionateScreenHeight(13)),
                          child: Text("Apply Coupon Code",style: TextStyle(fontSize: getProportionateScreenWidth(12),color: kPrimaryColor2,),
                          ),
                        )
                    ),
                    prefixIcon: Text('₹',style: TextStyle(fontSize: getProportionateScreenWidth(40),color: ruppeecolor),),
                    // prefixStyle: TextStyle(fontSize: getProportionateScreenWidth(45)),
                    hintText: 'Amount',
                    hintStyle: TextStyle(fontSize: getProportionateScreenWidth(30),fontWeight: FontWeight.bold,color: ruppeecolor),
                    contentPadding:EdgeInsets.only(bottom: getProportionateScreenHeight(13))
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(100),),
            DefaultButton(
              color: kPrimaryColor2,
              text: " Proceed",
              press: () {
                print(amount);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AfterOrevWallet(transaction: false,)),
                );
                // generateTxnToken();
              },
            )
          ],
        ),
      ),
    );
  }
}
