import 'package:flutter/material.dart';
import 'package:orev/components/coustom_bottom_nav_bar.dart';
import 'package:orev/enums.dart';

import 'components/body.dart';

class SeeMore extends StatefulWidget {
  static String routeName = "/seemore";
  final String categoryId;
  final String title;
  SeeMore({this.categoryId, this.title});
  @override
  _SeeMoreState createState() =>
      _SeeMoreState(categoryId: categoryId, title: title);
}

class _SeeMoreState extends State<SeeMore> {
  static String routeName = "/seemore";
  final String categoryId;
  final String title;
  _SeeMoreState({this.categoryId, this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(categoryId: categoryId, title: title),
    );
  }
}
