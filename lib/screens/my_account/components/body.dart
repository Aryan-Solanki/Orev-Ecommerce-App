import 'package:flutter/material.dart';
import 'package:orev/screens/my_account/components/update_profile_form.dart';
import 'package:orev/screens/profile/components/profile_pic.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Hello Aryan!!", style: headingStyle),
              Text(
                "Update your profile",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              ProfilePic(camera: true,),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              UpdateProfileForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Text(
                'By continuing your confirm that you agree \nwith our Term and Condition',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
