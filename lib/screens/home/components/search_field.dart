import 'package:flutter/material.dart';
import 'package:orev/components/search_page.dart';
import 'package:orev/screens/address/address.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatefulWidget {
  final bool simplebutton;
  const SearchField({
    bool this.simplebutton=true,
    Key key,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  FocusNode focusNode= FocusNode();
  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return widget.simplebutton==true?GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()));
      },
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(13)),
        width: SizeConfig.screenWidth * 0.6,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(Icons.search,size: getProportionateScreenWidth(18),color: kTextColor,),
            SizedBox(width: getProportionateScreenWidth(10),),
            Text("Search product",style: TextStyle(fontSize: getProportionateScreenWidth(15)),)
          ],
        ),
      ),
    ):Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(fontSize: getProportionateScreenWidth(15)),
        focusNode: focusNode,
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical:getProportionateScreenWidth(13)),
                // horizontal: getProportionateScreenWidth(20),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            hintStyle:TextStyle(fontSize: getProportionateScreenWidth(15)),
            prefixIcon: Icon(Icons.search,size: getProportionateScreenWidth(18))),
      ),
    );

  }
}

