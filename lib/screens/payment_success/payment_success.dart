import 'package:flutter/material.dart';
import 'package:orev/constants.dart';

import 'components/body.dart';

class PaymentSuccess extends StatefulWidget {
  static String routeName = "/paymment_success";
  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Success"),
        ),
        body: Body(),
      ),
    );
  }
}
