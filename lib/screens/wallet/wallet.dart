import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

class Wallet extends StatefulWidget {
  static String routeName = "/Wallet";

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
