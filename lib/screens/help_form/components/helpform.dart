
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:orev/components/default_button.dart';
import 'package:orev/components/form_error.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/services/product_services.dart';
import 'package:search_choices/search_choices.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu_button/menu_button.dart';



class HelpForm extends StatefulWidget {
  @override
  _HelpFormState createState() => _HelpFormState();
}

class _HelpFormState extends State<HelpForm> with ChangeNotifier {

  String selectedKey="Please Select";

  List<String> keys = <String>[
    'Low',
    'Medium',
    'High',
  ];




  final _formKey = GlobalKey<FormState>();
  @override
  String message="";
  Widget build(BuildContext context) {
    final Widget normalChildButton = Container(

      height: getProportionateScreenHeight(getProportionateScreenHeight(90)),
      child: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(20),bottom: getProportionateScreenHeight(20),left: getProportionateScreenWidth(40),right: getProportionateScreenWidth(20) ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Text(selectedKey,style: TextStyle(fontSize: getProportionateScreenWidth(13)), overflow: TextOverflow.ellipsis)
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.arrow_drop_down,
                // color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MenuButton<String>(
            // itemBackgroundColor: Colors.transparent,
            menuButtonBackgroundColor: Colors.transparent,
            decoration: BoxDecoration(
                border: Border.all(
                  color: kTextColor,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(28)
                )

            ),
            child: normalChildButton,
            items: keys,
            itemBuilder: (String value) => Container(
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
              child: Text(value,style: TextStyle(fontSize: getProportionateScreenWidth(13)), overflow: TextOverflow.ellipsis),
            ),
            toggledChild: Container(
              child: normalChildButton,
            ),
            onItemSelected: (String value) {
              setState(() {
                selectedKey = value;
              });
            },
            onMenuButtonToggle: (bool isToggle) {
              print(isToggle);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          MessageFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {

            },
          ),
        ],
      ),
    );
  }


  TextFormField MessageFormField() {
    return TextFormField(
      onChanged: (value) {
        message = value;
      },
      decoration: InputDecoration(
        labelText: "Message (Optional)",
        hintText: "Please enter your message ... ",
        hintStyle: TextStyle(fontSize: getProportionateScreenWidth(13)),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

}
