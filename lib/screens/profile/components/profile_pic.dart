import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orev/size_config.dart';

class ProfilePic extends StatelessWidget {
  final bool camera;
  const ProfilePic({
    Key key,
    this.camera=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(160),
      width: getProportionateScreenHeight(160),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Profile Image.png"),
          ),
          camera==true?Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: getProportionateScreenWidth(38),
              width: getProportionateScreenWidth(38),
              child: FlatButton(
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {},
                child: Expanded(child: SvgPicture.asset("assets/icons/Camera Icon.svg")),
              ),
            ),
          ):Center(),
        ],
      ),
    );
  }
}
