import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orev/screens/home/components/DesktopHomeHeader.dart';
import 'package:orev/screens/home/components/TabletHomeHeader.dart';
import 'package:orev/screens/home/components/home_header.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../enums.dart';
import '../size_config.dart';
import 'coustom_bottom_nav_bar.dart';

class ComingSoon extends StatefulWidget {
  final String value;
  final bool bottomNavigation;
  final bool animation;
  const ComingSoon({
    Key key,
    @required this.value,
    @required this.bottomNavigation,
    @required this.animation,
  }) : super(key: key);

  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  ResponsiveBuilder(
                    builder: (context, sizingInformation) {
                      // Check the sizing information here and return your UI
                      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                        return DesktopHomeHeader();
                      }

                      if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                        return TabletHomeHeader();
                      }

                      return HomeHeader();
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
                    child: Column(
                      children:[
                        Text(
                          "Orev",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(35),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        Text(
                          widget.value,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(30),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(150),),
                        widget.animation==true?Lottie.asset("assets/animation/comming-soon.json"):
                        // Center(
                        //   child: Text(
                        //     "If you wish to register yourself as a vendor,  please write at contact@orevhealth.com",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: getProportionateScreenHeight(15),
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "If you wish to register yourself as a vendor,  please write at ", style: TextStyle(fontSize: getProportionateScreenHeight(15),)),
                                TextSpan(text: 'contact@orevhealth.com',
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () { launch('mailto:contact@orevhealth.com');
                                      },
                                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: getProportionateScreenHeight(15),)),
                              ],
                            ),
                            textAlign:  TextAlign.center,
                          ),
                        )
                      ]
                    ),
                  )
                ],
              ),
            )),
        bottomNavigationBar: widget.bottomNavigation==true?ResponsiveBuilder(
          builder: (context, sizingInformation) {
            // Check the sizing information here and return your UI
            if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
              return Visibility(visible: false,child: CustomBottomNavBar(selectedMenu: MenuState.home));
            }

            if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
              return CustomBottomNavBar(selectedMenu: MenuState.home);
            }

            if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
              return CustomBottomNavBar(selectedMenu: MenuState.home);
            }

            return CustomBottomNavBar(selectedMenu: MenuState.home);
          },
        ):Visibility(visible: false,child: CustomBottomNavBar(selectedMenu: MenuState.home)),
      ),
    );
  }
}
