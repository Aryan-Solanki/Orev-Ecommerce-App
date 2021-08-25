import 'package:flutter/material.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Order.dart';
import 'package:orev/screens/home/home_screen.dart';

import '../Order_Details/components/components/body.dart';
import 'components/body.dart';

class MultiplePaymentSuccess extends StatefulWidget {
  static String routeName = "/multiple_paymment_success";
  final bool transaction_success;
  final Order order;
  final bool cod;
  MultiplePaymentSuccess(
      {@required this.transaction_success,
        @required this.order,
        @required this.cod});
  @override
  _MultiplePaymentSuccessState createState() => _MultiplePaymentSuccessState();
}

class _MultiplePaymentSuccessState extends State<MultiplePaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.transaction_success
                ? "Payment Success"
                : "Payment Failure"),
          ),
          body: Body(
            transaction: widget.transaction_success,
            order: widget.order,
            cod: widget.cod,
          ),
        ),
      ),
    );
  }
}