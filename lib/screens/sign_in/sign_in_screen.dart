import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key key,
    this.snackbar=false,
  }) : super(key: key);
  final bool snackbar;
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldstate= new GlobalKey<ScaffoldState>();
    if(snackbar){
      print("errrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      FocusScope.of(context).unfocus();
      _scaffoldstate.currentState
          .showSnackBar(SnackBar(content: Text('Password Changed')));
    }
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Body(),
    );
  }
}
