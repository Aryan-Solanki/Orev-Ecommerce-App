import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orev/components/custom_surfix_icon.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/form_error.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/complete_profile/complete_profile_screen.dart';
import 'package:orev/screens/home/home_screen.dart';
import 'package:orev/services/user_services.dart';
import 'package:search_choices/search_choices.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'city_and_states.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  String password;
  String conform_password;
  bool remember = false;
  String phone;
  String Name;
  List<String> errors = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  String selectedValueSingleDialog = "";
  String selected_state="";
  String selected_city="Search for your City";

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  String number;
  @override
  Widget build(BuildContext context) {


    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildAddressFormField("Address Line 1","House Number ,Floor ,Building"),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField("Address Line 2","Street Address ,P.O.Box ,Company Name"),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Color(0xff565656),
              ),
            ),
            child: SearchChoices.single(
              onClear: (){
                setState(() {
                  selected_state="";
                  selected_city="Search for your City";
                });
              },
              padding: 30,
              underline: NotGiven(),
              selectedValueWidgetFn: (item) {
                return Container(
                    transform: Matrix4.translationValues(-10,0,0),
                    alignment: Alignment.centerLeft,
                    child: (Text(item.toString())));
              },
              items: state(),
              value: selected_state,
              hint: "Search for your State",
              onChanged: (value) {

                if (value != null) {
                  setState(() {
                    selected_state = value;
                  });
                }

// selectedValueSingleDialog = value;
              },
              isExpanded: true,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20),horizontal: getProportionateScreenWidth(13)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Color(0xff565656), 
              ),
            ),
            child: SearchChoices.single(
              onClear: (){
                selected_city="Search for your City";
              },
              padding: 30,
              underline: NotGiven(),
              selectedValueWidgetFn: (item) {
                return Container(
                    transform: Matrix4.translationValues(-10,0,0),
                    alignment: Alignment.centerLeft,
                    child: (Text(item.toString())));
              },
              hint: "Search for your City",
              items: city(selected_state),
              value: selected_city,
              onChanged: (value) {
                if (value != null) {
                  selected_city = value;
                }

// selectedValueSingleDialog = value;
              },
              isExpanded: true,
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              print(selected_state);
              print(selected_city);
              errors = [];
              if (_formKey.currentState.validate() && selected_state!="" && selected_city!="Search for your City"){
                print("nexxxxxxxxxxt pageeeee");
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField(String Address,String Hint) {
    return TextFormField(
      onSaved: (newValue) => Name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: Address,
        hintText: Hint,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }


}
