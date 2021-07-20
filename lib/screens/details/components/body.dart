import 'package:flutter/material.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/rounded_icon_btn.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';

class Body extends StatefulWidget {
  final Product product;
  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(product:this.product);
}


class _BodyState extends State<Body> {
  _BodyState({@required this.product});

  List<String> _foodVariants = [
    "Chicken grilled",
    "Pork grilled",
    "Vegetables as is",
    "Cheese as is",
    "Bread tasty"
  ];
  int selectedFoodVariants = 0;

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }
  getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }
  // void _showScaffold() {
  //   final snackBar = SnackBar(content: Text('Hold and drag instead of tap'));
  //   scaffoldKey.currentState?.showSnackBar(snackBar);
  // }

  final Product product;
  @override
  Widget build(BuildContext context) {
    return DirectSelectContainer(
      child: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                ),
                TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0),
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: DirectSelectList<String>(
                                    values: _foodVariants,
                                    defaultItemIndex: 3,
                                    itemBuilder: (String value) => getDropDownMenuItem(value),
                                    focusedItemDecoration: getDslDecoration(),
                                    onItemSelectedListener: (item, index, context) {

                                    })),
                            Icon(
                              Icons.unfold_more,
                              color: Colors.black,
                            ),
                            Spacer(),
                            RoundedIconBtn(
                              icon: Icons.remove,
                              press: () {},
                            ),
                            SizedBox(width: getProportionateScreenWidth(20)),
                            RoundedIconBtn(
                              icon: Icons.add,
                              showShadow: true,
                              press: () {},
                            ),
                          ],
                        ),
                      ),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.1,
                            right: SizeConfig.screenWidth * 0.1,
                            bottom: getProportionateScreenWidth(30),
                            top: getProportionateScreenWidth(10),
                          ),
                          child: Column(
                            children: [
                              DefaultButton(
                                color: kPrimaryColor2,
                                text: "Buy Now",
                                press: () {},
                              ),
                              SizedBox(height:getProportionateScreenHeight(15) ,),
                              DefaultButton(
                                text: "Add To Cart",
                                press: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
