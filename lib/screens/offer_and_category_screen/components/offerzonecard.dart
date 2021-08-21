import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_skeleton/loading_skeleton.dart';
import 'package:orev/size_config.dart';

import '../../../constants.dart';

class OfferzoneCard extends StatefulWidget {

  @override
  _OfferzoneCardState createState() => _OfferzoneCardState();
}

class _OfferzoneCardState extends State<OfferzoneCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(getProportionateScreenWidth(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(10)),
          color: kSecondaryColor.withOpacity(0.1),
        ),
        width: getProportionateScreenWidth(160),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          imageUrl:
          "https://www.bigbasket.com/media/uploads/p/xxl/204629_15-aashirvaad-select-atta.jpg",
          // widget.product.varients[defaultVarient].images[0],
          placeholder: (context, url) => new LoadingSkeleton(
            width: getProportionateScreenWidth(700),
            height: getProportionateScreenHeight(700),
          ),
          errorWidget: (context, url, error) =>
          new Icon(Icons.error),
        ),
      ),
    );
  }
}
