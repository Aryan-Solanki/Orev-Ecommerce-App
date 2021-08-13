import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

class AddMoney extends StatefulWidget {
  static String routeName = "/add_money";

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Add Money",style: TextStyle(
        fontSize: getProportionateScreenWidth(18),
      ),),
    );
  }
}
