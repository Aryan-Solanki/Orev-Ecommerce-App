import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:orev/constants.dart';
import 'package:orev/screens/help_form/help_form.dart';
import 'package:orev/screens/my_account/my_account.dart';
import 'package:orev/screens/your_order/your_order.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(20),vertical: getProportionateScreenHeight(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Welcome to",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(27),
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              " Customer Service",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(27),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(25),),
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: kPrimaryColor,
                  width: 2.0,
                ),
              ),
              child:Text("Orev is focused on the health and safety of both the customers and associates.If your address lies in an area with local restrictions ,then your order might get delayed. You may also call us.For fast and easy self-help solutions.\nThank you for your patience",
                style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(14),
              )
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(25),),
            Text(
              " Quick Links ",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20),),
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              child:Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, YourOrder.routeName);
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(left: getProportionateScreenWidth(10),bottom: getProportionateScreenHeight(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Your Orders",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getProportionateScreenWidth(15),
                                    ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Track or  view your order",
                                  style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                ),

                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, MyAccount.routeName);
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(left: getProportionateScreenWidth(10),top: getProportionateScreenHeight(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Account Setting",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getProportionateScreenWidth(15),
                                    ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Edit Username,address or wallet details",
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(12),
                                    ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                ),

                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
            SizedBox(height: getProportionateScreenHeight(25),),
            Text(
              " Need More Help ",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20),),
            Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                child:GFAccordion(
                  expandedTitleBackgroundColor: Colors.white,
                  titleChild: Text("Contact Us",style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(15),
                  ),),
                  // content: 'GetFlutter is an open source library that comes with pre-build 1000+ UI components.'
                  contentChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact Number: +91 70489 62990",style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),),
                      SizedBox(height: getProportionateScreenHeight(7),),
                      Text("Contact Email: contact@orevhealth.com",style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),),
                      SizedBox(height: getProportionateScreenHeight(7),),
                      Text("Business Address: A1/356, Sushant Lok 2, Sector 55, Gurgaon, Haryana, India - 122011",style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),),

                    ],
                  ),

                )
            ),
            SizedBox(height: getProportionateScreenHeight(20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "For further queries fill this",
                  style: TextStyle(fontSize: getProportionateScreenWidth(13)),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, HelpForm.routeName),
                  child: Text(
                    " Form",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(13),
                        color: kPrimaryColor),
                  ),
                ),
              ],
            )




          ],
        ),
      ),
    );
  }
}
