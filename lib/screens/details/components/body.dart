import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/product_card.dart';
import 'package:orev/components/rounded_icon_btn.dart';
import 'package:orev/constants.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/screens/address/address.dart';
import 'package:orev/size_config.dart';
import 'package:search_choices/search_choices.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class Body extends StatefulWidget {
  final Product product;
  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(product:this.product);
}


class _BodyState extends State<Body> {
  _BodyState({@required this.product});
  List<String> UserAddress = [
    "400-B,Pocket-N,Sarita Vihar ,New Delhi,110076",
    "Golden Temple Rd, Atta Mandi, Katra Ahluwalia, Amritsar, Punjab 143006",
    "Netaji Subhash Marg, Lal Qila, Chandni Chowk, New Delhi, Delhi 110006"
  ];

  List<String> _foodVariants = [
    "Chicken grilled Chicken grilled Chicken grilled",
    "Pork grilled",
    "Vegetables as is",
    "Cheese as is",
    "Bread tasty"
  ];
  int selectedFoodVariants = 0;
  int quantity=1;
  bool outofstock=false;
  String SelectedAddress="";
  int _radioSelected;
  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value,style: TextStyle(color: Colors.black,fontSize: getProportionateScreenHeight(18)),);
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
    void _showDialog() {
      slideDialog.showSlideDialog(
          context: context,
        child: Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  Text(
                    "Select Delivery Address",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              StatefulBuilder(builder: (context, StateSetter setState){
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: UserAddress.length,
                  itemBuilder: (context, i) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xff565656),
                          ),
                        ),
                        child: Row(
                          children: [
                            Radio(
                              value: i,
                              groupValue: _radioSelected,
                              onChanged: (ind) {
                                _radioSelected = ind;
                                setState(() {
                                  SelectedAddress = UserAddress[i];
                                  print(SelectedAddress);
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                UserAddress[i],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )

                    );
                  },
                );
              },
              ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      // onTap: () => Navigator.pushNamed(
                      //     context, ForgotPasswordScreen.routeName),
                      child: Text(
                        "Add New Address",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  SwipeButton(
                    thumb: Icon(
                      Icons.double_arrow_outlined
                    ),
                    activeThumbColor: kPrimaryColor4,
                    borderRadius: BorderRadius.circular(8),
                    activeTrackColor: kPrimaryColor3,
                    height: getProportionateScreenHeight(80),
                    child: Text(
                      "Swipe to place your order",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(13),
                      ),
                    ),
                    onSwipe: () {
                        print("Order Placed");
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  DefaultButton(
                    textheight: 13,
                    colour: Colors.black,
                    height: 70,
                    color: kPrimaryColor2,
                    text: "Pay Online",
                    press: () {
                      if(UserAddress.isEmpty){
                        Navigator.pushNamed(context, Address.routeName);
                      }
                      else{
                        _showDialog();
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),

                ],
              ),
            ),
          ),
        )
      );
    }

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
                                    defaultItemIndex: selectedFoodVariants,
                                    itemBuilder: (String value) => getDropDownMenuItem(value),
                                    focusedItemDecoration: getDslDecoration(),
                                    onItemSelectedListener: (item, index, context) {
                                      selectedFoodVariants=index;
                                    })),
                            // SizedBox(width: getProportionateScreenWidth(100),),
                            Icon(
                              Icons.unfold_more,
                              color: Colors.black,
                            ),
                            SizedBox(width: getProportionateScreenWidth(15),),
                            RoundedIconBtn(
                              icon: Icons.remove,
                              press: () {
                                if(quantity!=1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                                },
                            ),
                            SizedBox(width: getProportionateScreenWidth(20)),
                            Text("x "+quantity.toString(),style: TextStyle(color: Colors.black,fontSize: getProportionateScreenHeight(20)),),
                            SizedBox(width: getProportionateScreenWidth(20)),
                            RoundedIconBtn(
                              icon: Icons.add,
                              showShadow: true,
                              press: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      outofstock==false?TopRoundedContainer(
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
                                press: () {
                                  if(UserAddress.isEmpty){
                                    Navigator.pushNamed(context, Address.routeName);
                                  }
                                  else{
                                    _showDialog();
                                  }
                                },
                              ),
                              SizedBox(height:getProportionateScreenHeight(15) ,),
                              DefaultButton(
                                text: "Add To Cart",
                                press: () {},
                              )
                            ],
                          ),
                        ),
                      ):TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.1,
                            right: SizeConfig.screenWidth * 0.1,
                            bottom: getProportionateScreenWidth(30),
                            top: getProportionateScreenWidth(10),
                          ),
                          child: DefaultButton(
                            color: kSecondaryColor,
                            text: "Out of Stock",
                            press: () {},
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(15),bottom: getProportionateScreenWidth(5)),
                  child: Text("You Might Also Like",style: smallerheadingStyle,),
                ),
                SizedBox(height: getProportionateScreenHeight(10),),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        demoProducts.length,
                            (index) {
                          if (demoProducts[index].isPopular)
                            return ProductCard(product: demoProducts[index]);

                          return SizedBox
                              .shrink(); // here by default width and height is 0
                        },
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



