import 'package:flutter/material.dart';
import 'package:orev/components/custom_surfix_icon.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/form_error.dart';
import 'package:orev/components/no_account_text.dart';
import 'package:orev/size_config.dart';
import '../../../constants.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'package:pinput/pin_put/pin_put.dart';
import 'package:pinput/pin_put/pin_put_state.dart';


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

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Color(0xffededed),
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
            Text(
              "Please enter the OTP that you have received on \nyour provided phone number",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
            Container(
              child: PinPut(
                fieldsCount: 6,
                onSubmit: (pin) async {

                },
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                selectedFieldDecoration: _pinPutDecoration,
                followingFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.deepPurpleAccent.withOpacity(.5),
                  ),
                ),
              ),
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
  String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kPhoneNumberNullError)) {
                setState(() {
                  errors.remove(kPhoneNumberNullError);
                });
              } else if (value.length == 10) {
                setState(() {
                  errors.remove(kShortNumberError);
                  errors.remove(kLongNumberError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kPhoneNumberNullError)) {
                setState(() {
                  errors.add(kPhoneNumberNullError);
                });
              } else if (value.length < 10) {
                setState(() {
                  errors.add(kShortNumberError);
                });
              } else if (value.length > 10) {
                setState(() {
                  errors.add(kLongNumberError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Phone",
              hintText: "Enter your phone",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              errors = [];
              if (_formKey.currentState.validate()) {
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
}
