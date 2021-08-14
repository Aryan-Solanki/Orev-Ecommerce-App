import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:orev/components/custom_surfix_icon.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/form_error.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/address/address.dart';
import 'package:orev/screens/complete_profile/complete_profile_screen.dart';
import 'package:orev/screens/home/home_screen.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_services.dart';
import 'package:search_choices/search_choices.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';


class UpdateProfileForm extends StatefulWidget {
  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> with ChangeNotifier {
  String newname;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<dynamic> addressmap = [];
  String user_key;

  Future<void> getAllAddress() async {
    ProductServices _services = ProductServices();
    print(user_key);
    var userref = await _services.users.doc(user_key).get();
    addressmap = userref["address"];
  }

  @override
  void initState() {
    super.initState();
    user_key = AuthProvider().user.uid;
    getAllAddress();
    super.initState();
  }

  String pincode;
  @override
  Widget build(BuildContext context) {
    Future<void> setAddress(addressDict) async {
      addressmap.add(addressDict);
      ProductServices _services = ProductServices();
      print(user_key);
      var finalmap = {"address": addressmap};
      await _services.updateAddress(finalmap, user_key);
      Navigator.pop(context, true);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUpdateNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: kTextColor)
            ),
            child: Column(
              children: [
                GFAccordion(
                  expandedTitleBackgroundColor: Colors.white,
                  contentPadding: EdgeInsets.only(bottom: 0,top: 0),
                  titlePadding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
                  titleChild: Text("My Addresses (3)",style: TextStyle(fontSize: getProportionateScreenWidth(15)),),
                  // content: 'GetFlutter is an open source library that comes with pre-build 1000+ UI components.'
                  contentChild: Padding(
                    padding: EdgeInsets.only(top: 10,left: getProportionateScreenWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, i){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: getProportionateScreenHeight(10),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Akshat Rastogi",style: TextStyle(fontSize: getProportionateScreenWidth(13)),),
                                      GestureDetector(
                                          onTap: (){
                                            SimpleAlertBox(context: context);
                                          },
                                          child: Icon(Icons.delete_outline,size: getProportionateScreenWidth(20),color: kPrimaryColor,)
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("400-B,Pocket-N",style: TextStyle(
                                            fontSize: getProportionateScreenHeight(15))),
                                        Text("Sarita Vihar",style: TextStyle(
                                            fontSize: getProportionateScreenHeight(15))),
                                        Text("New Delhi",style: TextStyle(
                                            fontSize: getProportionateScreenHeight(15))),
                                        Text("Delhi",style: TextStyle(
                                            fontSize: getProportionateScreenHeight(15))),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(10),),
                                  Divider(
                                      color: Colors.black
                                  )
                                ],
                              );
                            }
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,
                                Address.routeName);
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Add New Address",
                              style: TextStyle(
                                color: Colors.blue,
                                  decoration:
                                  TextDecoration.underline),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(20),top: getProportionateScreenWidth(20),bottom: getProportionateScreenWidth(20),left: getProportionateScreenWidth(30)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: kTextColor)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Orev Balance",style: TextStyle(fontSize: getProportionateScreenWidth(15)),),
                Text("₹300.34",style: TextStyle(fontSize: getProportionateScreenWidth(15)),)
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Update",
            press: () async {
              print(newname);
            },
          ),
        ],
      ),
    );
  }


  TextFormField buildUpdateNameFormField() {
    return TextFormField(
      // onSaved: (newValue) => Addressname = newValue,
      onChanged: (value) {
        newname=value;
      },
      decoration: InputDecoration(
        labelText: "New Name",
        hintText: "Aryan Solanki",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      // onSaved: (newValue) => Name = newValue,
      onChanged: (value) {

      },
      validator: (value) {

      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter Your Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
