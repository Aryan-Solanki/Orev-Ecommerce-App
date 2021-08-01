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
  DocumentSnapshot snapshot;
  List<String> errors = [];
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
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

  _verifyPhone() async {
    await auth.verifyPhoneNumber(
        phoneNumber: '+91' + number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("nothinggggg");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print("erorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 30));
  }

  Future<bool> Query(num) async {
    var bo = false;
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection("users").get();
    snapshot.docs.forEach((document) {
      if (document.exists) {
        if (document['number'] == num) {
          bo = true;
          return;
        }
      } else {
        print('document does not exist');
      }
    });
    return bo;
  }

  String _verificationCode;
  String number;
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context);
    UserServices _userServices = UserServices();
    String phone_uid;

    Widget boxedPinPutWithPreFilledSymbol() {
      final BoxDecoration pinPutDecoration = BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5.0),
      );

      return PinPut(
        withCursor: true,
        fieldsCount: 6,
        textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
        eachFieldWidth: 50.0,
        eachFieldHeight: 50.0,
        onSubmit: (String pin) async {
          try {
            await auth
                .signInWithCredential(PhoneAuthProvider.credential(
                verificationId: _verificationCode, smsCode: pin))
                .then((value) async {
              if (value.user != null) {

              }
            });
          } catch (e) {
            print(e);
          }
        },
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration:
        pinPutDecoration.copyWith(color: Colors.lightGreen),
        followingFieldDecoration: pinPutDecoration,
      );
    }

    void _showDialog() {
      slideDialog.showSlideDialog(
          context: context,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                Text(
                  "One Time Password",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                boxedPinPutWithPreFilledSymbol(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Text(
                  "Please enter the OTP that you have received on \nyour provided phone number $number",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
              ],
            ),
          ));
    }

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
                  print(selected_state);
                }

// selectedValueSingleDialog = value;
              },
              isExpanded: true,
            ),
          ),
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
              errors = [];
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                var bo = await Query("+91" + number);
                if (bo) {
                  addError(error: kUserExistsError);
                } else {
                  _verifyPhone();
                  _showDialog();
                }
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
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
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}
