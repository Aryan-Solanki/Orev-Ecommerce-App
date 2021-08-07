import 'package:flutter/material.dart';

import 'components/body.dart';

class PaytmIntegeration extends StatelessWidget {
  static String routeName = "/Paytm";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paytm"),
      ),
      body: Body(),
    );
  }
}
