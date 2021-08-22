import 'package:flutter/material.dart';

import 'components/body.dart';

class AllCategoryScreen extends StatefulWidget {
  static String routeName = "/allCategoryScreen";
  @override
  _AllCategoryScreenState createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(notifyParent: refresh),
      ),
    );
  }
}
