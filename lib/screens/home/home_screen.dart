import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orev/components/coustom_bottom_nav_bar.dart';
import 'package:orev/components/updateavailablescreen.dart';
import 'package:orev/enums.dart';
import 'package:orev/services/product_services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../constants.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firsttime = false;
  bool maintenance = false;
  bool updateAvailable = false;

  checkInitial() async {
    ProductServices _services = ProductServices();
    DocumentSnapshot check = await _services.initialChecks.get();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;

    if (version != check["currentVersion"] && check["updateAvailable"]) {
      updateAvailable = true;
    }

    maintenance = check["maintenance"];

    if (updateAvailable) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpdateAvailable(value: "Download Now",bottomNavigation: false,)),
      );
      print("Push to Update Screen");
    } else if (maintenance) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpdateAvailable(value: "Come Back Soon",bottomNavigation: false,)),
      );
      print("Push to Maintenance Screen");
    }
  }

  @override
  void initState() {
    firsttime = true;
    checkInitial();
    super.initState();
  }

  DateTime backbuttonpressedTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime currenttime = DateTime.now();
        bool backbutton = backbuttonpressedTime == null ||
            currenttime.difference(backbuttonpressedTime) >
                Duration(seconds: 2);
        if (backbutton) {
          backbuttonpressedTime = currenttime;
          Fluttertoast.showToast(
              msg: "Double Tap to close App",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 2,
              gravity: ToastGravity.BOTTOM);
          return false;
        }
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}
