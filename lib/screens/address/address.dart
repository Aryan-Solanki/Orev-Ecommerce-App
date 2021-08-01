import 'package:flutter/material.dart';

import 'components/body.dart';

class Address extends StatelessWidget {
  static String routeName = "/Address";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Form"),
      ),
      body: Body(),
    );
  }
}
