import 'package:flutter/material.dart';
import 'package:orev/components/custom_surfix_icon.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/form_error.dart';
import 'package:orev/components/no_account_text.dart';
import 'package:orev/size_config.dart';
import '../../../constants.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your phone number and we will send \nyou an otp to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override

  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

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
          await FirebaseAuth.instance
              .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: pin))
              .then((value) async {
            if (value.user != null) {
              print("hurray right pincode");
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
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
                "Please enter the OTP that you have received on \nyour provided phone number",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              DefaultButton(
                text: "Submit",
                press: () {
                  errors = [];
                  if (_formKey.currentState.validate()) {
                    //nxt pagee
                  }
                },
              )
            ],
          ),
        )

        // barrierColor: Colors.white.withOpacity(0.7),
        // pillColor: Colors.red,
        // backgroundColor: Colors.yellow,
        );
  }

  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
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
    await FirebaseAuth.instance.verifyPhoneNumber(
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
          print("e.message");
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
  String _verificationCode;
  String number;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(

            text: "Continue",
            press: () async {
              print(errors);
              errors = [];
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _verifyPhone();
                _showDialog();
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => number = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        } if (value.length == 10) {
          removeError(error: kShortNumberError);
          removeError(error: kLongNumberError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 10) {
          addError(error: kShortNumberError);

          return "";
        }
        else if (value.length > 10) {
          addError(error: kLongNumberError);

          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Number",
        hintText: "Enter your number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
