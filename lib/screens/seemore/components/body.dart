import 'package:flutter/material.dart';
import 'package:orev/screens/home/components/home_header.dart';

import '../../../size_config.dart';
import 'scrollview.dart';

class Body extends StatefulWidget {
  final String categoryId;
  final String title;
  Body({this.categoryId, this.title});
  @override
  _BodyState createState() => _BodyState(categoryId: categoryId);
}

class _BodyState extends State<Body> {
  final String categoryId;
  _BodyState({this.categoryId});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            AllItems(categoryId: categoryId, title: widget.title),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
