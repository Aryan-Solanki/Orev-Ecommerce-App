import 'package:flutter/material.dart';
import 'package:orev/components/coustom_bottom_nav_bar.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/screens/liked_item/components/LikeScreenDesktop.dart';
import 'package:orev/screens/liked_item/components/LikeScreenMobile.dart';
import 'package:orev/screens/liked_item/components/scrollview.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../enums.dart';
import 'components/LikeScreenTablet.dart';
import 'components/body.dart';

class LikedScreen extends StatefulWidget {
  static String routeName = "/liked_screen";
  @override
  _LikedScreenState createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenTypeLayout(
          mobile: LikeScreenMobile(),
          tablet: LikeScreenTablet(),
          desktop: LikeScreenDesktop(),
        ),
          bottomNavigationBar: ResponsiveBuilder(
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
          )
      ),
    );
  }
}
