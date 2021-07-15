import 'package:flutter/material.dart';
import 'package:orev/screens/home/home_screen.dart';
import 'package:orev/screens/splash/components/body.dart';
import 'package:orev/services/user_simple_preferences.dart';
import 'package:orev/size_config.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String authkey = '';

  @override
  void initState() {
    authkey = UserSimplePreferences.getAuthKey() ?? '';
    super.initState();
    authkey = UserSimplePreferences.getAuthKey() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    authkey = UserSimplePreferences.getAuthKey() ?? '';
    return AnimatedSplashScreen(
        duration: 1,
        splashIconSize: getProportionateScreenWidth(150),
        splash: 'assets/images/splash_1.png',
        nextScreen: (authkey == '')
            ? Scaffold(
                body: Body(),
              )
            : HomeScreen()
        // splashTransition: SplashTransition.rotationTransition,
        // pageTransitionType: pageTransitionType.scale,
        );
  }
}
