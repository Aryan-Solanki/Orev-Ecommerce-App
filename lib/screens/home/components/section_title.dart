import 'package:flutter/material.dart';
import 'package:orev/screens/seemore/seemore.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.press,
    @required this.seemore=true,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  final bool seemore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        seemore==true?GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, SeeMore.routeName);
          },
          child: Text(
            "See More",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ):Text(""),
      ],
    );
  }
}
