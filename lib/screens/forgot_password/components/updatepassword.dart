import 'package:flutter/material.dart';
import 'package:orev/constants.dart';
import 'package:orev/size_config.dart';

import 'update_form.dart';

class UpdatePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Update Password", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                UpdateForm(),
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
      ),
    );
  }
}
