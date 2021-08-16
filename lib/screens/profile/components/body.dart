import 'package:flutter/material.dart';
import 'package:orev/screens/help_center/help_center.dart';
import 'package:orev/screens/my_account/my_account.dart';
import 'package:orev/screens/your_order/your_order.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(camera: false,),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context,
                  MyAccount.routeName);
            },
          ),
          ProfileMenu(
            text: "Your Orders",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.pushNamed(context,
                  YourOrder.routeName);
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.pushNamed(context,
                  HelpCenter.routeName);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
