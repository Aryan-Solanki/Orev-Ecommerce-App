import 'package:flutter/material.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Order.dart';

import 'components/body.dart';

class PaymentSuccess extends StatefulWidget {
  static String routeName = "/paymment_success";
  final bool transaction_success;
  final Order order;
  PaymentSuccess({@required this.transaction_success, @required this.order});
  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.transaction_success
              ? "Payment Success"
              : "Payment Failure"),
        ),
        body:
            Body(transaction: widget.transaction_success, order: widget.order),
      ),
    );
  }
}
