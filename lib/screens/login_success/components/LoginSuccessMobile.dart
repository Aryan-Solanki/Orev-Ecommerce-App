import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/screens/home/home_screen.dart';
import 'package:orev/size_config.dart';

class LoginSuccessMobile extends StatefulWidget {
  @override
  _LoginSuccessMobileState createState() => _LoginSuccessMobileState();
}

class _LoginSuccessMobileState extends State<LoginSuccessMobile> {
  @override
  void initState() {
    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset("assets/animation/success.json", repeat: false),
    );
  }
}
