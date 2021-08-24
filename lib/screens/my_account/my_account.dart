import 'package:flutter/material.dart';

import 'components/body.dart';

class MyAccount extends StatefulWidget {
  static String routeName = "/my_account";

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
