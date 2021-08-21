import 'package:flutter/material.dart';

import 'components/body.dart';

class OfferzoneCategory extends StatefulWidget {
  static String routeName = "/offerzone_category";
  @override
  _OfferzoneCategoryState createState() => _OfferzoneCategoryState();
}

class _OfferzoneCategoryState extends State<OfferzoneCategory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
