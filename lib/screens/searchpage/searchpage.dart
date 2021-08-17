import 'package:flutter/material.dart';
import 'package:orev/components/coustom_bottom_nav_bar.dart';
import 'package:orev/enums.dart';
import 'package:orev/models/Product.dart';

import 'components/body.dart';

class SearchResultsPage extends StatefulWidget {
  static String routeName = "/SearchResultsPage";
  final List<Product> productList;
  final String title;
  SearchResultsPage({this.productList, this.title});
  @override
  _SearchResultsPageState createState() =>
      _SearchResultsPageState(productList: productList, title: title);
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  static String routeName = "/SearchResultsPage";
  final List<Product> productList;
  final String title;

  _SearchResultsPageState({this.productList, this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(productList: productList, title: title),
    );
  }
}
