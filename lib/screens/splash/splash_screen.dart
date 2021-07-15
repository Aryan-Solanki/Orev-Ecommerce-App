import 'package:flutter/material.dart';
import 'package:orev/screens/splash/components/body.dart';
import 'package:orev/size_config.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';



class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return AnimatedSplashScreen(
      duration: 1,
      splashIconSize: getProportionateScreenWidth(150),
      splash: 'assets/images/splash_1.png',
      nextScreen: Scaffold(
        body: Body(),
      ),
      // splashTransition: SplashTransition.rotationTransition,
      // pageTransitionType: pageTransitionType.scale,
    );
  }
}

