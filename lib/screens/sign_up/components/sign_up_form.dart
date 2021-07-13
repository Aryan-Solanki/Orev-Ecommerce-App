import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orev/components/custom_surfix_icon.dart';
import 'package:orev/components/default_button.dart';
import 'package:orev/components/form_error.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/complete_profile/complete_profile_screen.dart';
import 'package:orev/screens/home/home_screen.dart';
import 'package:orev/services/user_services.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with ChangeNotifier {
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
    Future<void> createNewUser(number, name, password) async {
      String uid_real;
      var tempemail = number + "@orev.user";
      await _auth.signUp(email: tempemail, password: password);
      uid_real = _auth.user.uid;
      print("Email UID is $uid_real");
      Map<String, dynamic> UserInfo = {
        "id": uid_real,
        "name": name,
        "number": "+91" + number,
        "address": null
      };
      _userServices.createUserData(UserInfo);
      Navigator.pushNamed(context, HomeScreen.routeName);
    }

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
                print("Phone Auth " + auth.currentUser.uid);
                auth.signOut();
                createNewUser(number, Name, password);
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
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
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

  TextFormField buildFirstNameFormField() {
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
        labelText: "Full Name",
        hintText: "Enter your full name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
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

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => number = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        if (value.length == 10) {
          removeError(error: kShortNumberError);
          removeError(error: kLongNumberError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        if (value.length < 10) {
          addError(error: kShortNumberError);

          return "";
        }
        if (value.length > 10) {
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

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}
