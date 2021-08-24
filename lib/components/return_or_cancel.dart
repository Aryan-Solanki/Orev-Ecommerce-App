import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:orev/components/querysuccess.dart';

import '../constants.dart';
import '../size_config.dart';
import 'default_button.dart';

class ReturnCancel extends StatefulWidget {
  final String formname;
  ReturnCancel({@required this.formname});
  @override
  _ReturnCancelState createState() => _ReturnCancelState();
}

class _ReturnCancelState extends State<ReturnCancel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
                  Text(widget.formname, style: headingStyle),
                  Text(
                    "Complete your details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  ReturnCancelForm(formname: widget.formname,),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Text(
                    'By continuing your confirm that you agree \nwith our Term and Condition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class ReturnCancelForm extends StatefulWidget {
  final String formname;
  ReturnCancelForm({@required this.formname});
  @override
  _ReturnCancelFormState createState() => _ReturnCancelFormState();
}

class _ReturnCancelFormState extends State<ReturnCancelForm> with ChangeNotifier {


  List<String> Returnkeys = <String>[
    'Returning',
    'Ordering',
    'Payments & Pricing',
    'Orev Wallet',
    'Shipping & Delivery',
    'Returns & Refunds',
    'Security & Privacy',
    'Orev Vendor Account',
  ];
  List<String> Cancelkeys = <String>[
    'Cancel',
    'Ordering',
    'Payments & Pricing',
    'Orev Wallet',
    'Shipping & Delivery',
    'Returns & Refunds',
    'Security & Privacy',
    'Orev Vendor Account',
  ];

  final _formKey = GlobalKey<FormState>();
  @override
  String message = "";
  Widget build(BuildContext context) {
    String selectedKey = widget.formname=="Return Form"?"Reason for Return/Replacment":"Reason for Cancel";

    final Widget normalChildButton = Container(
      height: getProportionateScreenHeight(getProportionateScreenHeight(90)),
      child: Padding(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(20),
            bottom: getProportionateScreenHeight(20),
            left: getProportionateScreenWidth(40),
            right: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Text(selectedKey,
                    style: TextStyle(fontSize: getProportionateScreenWidth(13)),
                    overflow: TextOverflow.ellipsis)),
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
    return SingleChildScrollView(
      child: Form(
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
                  borderRadius: BorderRadius.all(Radius.circular(28))),
              child: normalChildButton,
              items: widget.formname=="Return Form"?Returnkeys:Cancelkeys,
              itemBuilder: (String value) => Container(
                height: getProportionateScreenHeight(
                    getProportionateScreenHeight(90)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(20),
                    horizontal: getProportionateScreenWidth(40)),
                child: Text(value,
                    style: TextStyle(fontSize: getProportionateScreenWidth(13)),
                    overflow: TextOverflow.ellipsis),
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
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "Continue",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuerySuccess(queryname:widget.formname=="Return Form"?"Return":"Cancel",)),
                );
                // if (selectedKey != "Please Select" && message != "") {
                //   String authkey = UserSimplePreferences.getAuthKey() ?? "";
                //   var values = {
                //     "description": message,
                //     "topic": selectedKey,
                //     "id": authkey
                //   };
                //   UserServices _services = new UserServices();
                //   _services.registerComplaint(values);
                //
                //   //TODO: Show a query registered successfully screen sort of thing
                //
                // } else {
                //   if (message == "") {
                //     Fluttertoast.showToast(
                //         msg: "Write a message to continue",
                //         toastLength: Toast.LENGTH_SHORT,
                //         timeInSecForIosWeb: 2,
                //         gravity: ToastGravity.BOTTOM);
                //   } else if (selectedKey == "Please Select") {
                //     Fluttertoast.showToast(
                //         msg: "Please Select a valid  topic",
                //         toastLength: Toast.LENGTH_SHORT,
                //         timeInSecForIosWeb: 2,
                //         gravity: ToastGravity.BOTTOM);
                //   } else {
                //     Fluttertoast.showToast(
                //         msg: "Unknown error occured",
                //         toastLength: Toast.LENGTH_SHORT,
                //         timeInSecForIosWeb: 2,
                //         gravity: ToastGravity.BOTTOM);
                //   }

              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField MessageFormField() {
    return TextFormField(
      maxLines: 5,
      onChanged: (value) {
        message = value;
      },
      decoration: InputDecoration(
        labelText: widget.formname=="Return Form"?"Return/Replacement Message":"Cancellation Message",
        hintText: "Please enter your message ... ",
        hintStyle: TextStyle(fontSize: getProportionateScreenWidth(13)),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}