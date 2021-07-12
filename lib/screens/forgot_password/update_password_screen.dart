import 'package:flutter/material.dart';
import 'package:orev/screens/forgot_password/components/updatepassword.dart';

import 'components/body.dart';

class UpdatePasswordScreen extends StatelessWidget {
  static String routeName = "/update_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
      ),
      body: UpdatePassword(),
    );
  }
}
