import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../size_config.dart';

class ComingSoon extends StatefulWidget {
  final String value;
  const ComingSoon({
    Key key,
    @required this.value,
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
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Orev",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(35),
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Text(
                    widget.value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(150),),
                  Lottie.asset("assets/animation/comming-soon.json"),
                ],
              ),
            )),
      ),
    );
  }
}
