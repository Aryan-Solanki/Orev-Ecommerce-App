import 'package:flutter/material.dart';
import 'package:orev/constants.dart';
import 'package:orev/screens/help_form/components/helpform.dart';
import 'package:orev/screens/home/components/home_header.dart';
import 'package:orev/size_config.dart';



class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          HomeHeader(),
          SizedBox(height: getProportionateScreenHeight(10)),
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
                    Text("Help Form", style: headingStyle),
                    Text(
                      "Complete your details",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: getProportionateScreenWidth(15)),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    HelpForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    Text(
                      'By continuing your confirm that you agree \nwith our Term and Condition',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

