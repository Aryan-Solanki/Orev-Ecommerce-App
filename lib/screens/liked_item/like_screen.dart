import 'package:flutter/material.dart';
import 'package:orev/components/coustom_bottom_nav_bar.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/screens/liked_item/components/scrollview.dart';

import '../../enums.dart';
import 'components/body.dart';

class LikedScreen extends StatefulWidget {
  static String routeName = "/liked_screen";
  @override
  _LikedScreenState createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: AllItems(),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Liked Items",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
