import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class ProductDetailsArguments {
  final Product product;
  final Function() notifyParent;
  final int varientCartNum;
  ProductDetailsArguments(
      {@required this.product,
      @required this.notifyParent,
      this.varientCartNum});
}

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: agrs.product.rating),
      body: Body(product: agrs.product, varientNumberCart: agrs.varientCartNum),
    );
  }
}
