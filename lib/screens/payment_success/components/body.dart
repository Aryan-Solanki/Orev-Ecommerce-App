import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:orev/constants.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    bool transaction=false;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Row(
                children: [
                  transaction==true?Text("Transaction Successful ",style: TextStyle(fontSize: getProportionateScreenWidth(25),fontWeight: FontWeight.bold,color: Colors.black),):Text("Transaction Failed ",style: TextStyle(fontSize: getProportionateScreenWidth(25),fontWeight: FontWeight.bold,color: Colors.black),),
                  transaction==true?Icon(Icons.check_circle,color: kPrimaryColor,size: getProportionateScreenHeight(50),):Icon(Icons.error,color: Colors.red,size: getProportionateScreenHeight(50),)
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15),),
            transaction==true?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi Aryan Solanki,",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(18),
                      ),),
                      SizedBox(height: getProportionateScreenHeight(10),),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: kTextColor,fontSize: getProportionateScreenWidth(15)),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Thank you for placing order with us.Your order ",
                                style: TextStyle(fontSize: getProportionateScreenWidth(15),)),
                            TextSpan(
                                text: '"Organic Chakki Atta"',
                                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => print('click')),
                            TextSpan(
                                text: "\nWe will send a confirmation when your items ships.",
                                style: TextStyle(fontSize: getProportionateScreenWidth(15),)),

                          ],
                        ),
                      )

                    ],
                  ),

                ),
                SizedBox(height: getProportionateScreenHeight(15),),
                Text("Transition Details ",style: TextStyle(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.bold,color: Colors.black),),
                SizedBox(height: getProportionateScreenHeight(15),),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date: 3 March,2020 10:06:43 PM IST",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),),
                      Text("Seller: Aryan Tatwa Seller",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),),
                      Text("Order Id: NZER12THH4N45OPJ",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),),
                      Text("Status: Successful",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),),
                      Text("Payment Method: Online",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),),
                      Text("Transition amount: ₹6253",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),),

                    ],
                  ),

                ),
                SizedBox(height: getProportionateScreenHeight(15),),
                Text("Billing Address",style: TextStyle(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.bold,color: Colors.black),),
                SizedBox(height: getProportionateScreenHeight(15),),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("400-B,Pocket-N",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black)),
                      Text("Sarita Vihar",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black)),
                      Text("New Delhi-110076",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black)),
                      Text("Phone number: 7982916348",style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black)),
                    ],
                  ),

                ),
                SizedBox(height: getProportionateScreenHeight(15),),
              ],
            ):Column(
              children: [
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: Text("The transaction failed due to a technical error. If your money was debited you will get a refund within 24hrs.",style: TextStyle(color: Colors.black,fontSize: getProportionateScreenWidth(18)),),
                ),
                Text("06:34 AM, 1 Oct 2020",style: TextStyle(fontSize: getProportionateScreenWidth(14)),),
                Text("Transaction ID: Not Generated",style: TextStyle(fontSize: getProportionateScreenWidth(14))),
              ],
            )


          ],
        ),
      ),
    );
  }
}
