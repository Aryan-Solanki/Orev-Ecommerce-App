import 'package:flutter/material.dart';

import 'components/body.dart';


class HelpForm extends StatelessWidget {
  static String routeName = "/help_form";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Form"),
      ),
      body: Body(),
    );
  }
}