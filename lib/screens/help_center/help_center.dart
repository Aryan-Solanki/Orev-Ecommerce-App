import 'package:flutter/material.dart';

import 'components/body.dart';

class HelpCenter extends StatefulWidget {
  static String routeName = "/help_center";

  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
      ),
      body: Body(),
    );
  }
}
