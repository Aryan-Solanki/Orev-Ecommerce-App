import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:menu_button/menu_button.dart';
import 'package:orev/components/comingsoonpage.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/address/address.dart';
import 'package:orev/screens/cart/cart_screen.dart';
import 'package:orev/screens/liked_item/like_screen.dart';
import 'package:orev/screens/profile/profile_screen.dart';
import 'package:orev/screens/sign_in/sign_in_screen.dart';
import 'package:orev/services/product_services.dart';
import 'package:orev/services/user_services.dart';
import 'package:orev/services/user_simple_preferences.dart';

import '../../../constants.dart';
import '../../../enums.dart';
import '../../../size_config.dart';
import '../home_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class DesktopHomeHeader extends StatefulWidget {
  final bool simplebutton;
  final bool address;
  final Function func;
  final MenuState selectedMenu;
  const DesktopHomeHeader({
    @required this.selectedMenu,
    bool this.simplebutton = true,
    bool this.address = false,
    @required this.func,
    Key key,
  }) : super(key: key);

  @override
  _DesktopHomeHeaderState createState() => _DesktopHomeHeaderState();
}

class _DesktopHomeHeaderState extends State<DesktopHomeHeader> {



  final GlobalKey<CartScreenState> myCartScreenState =
  GlobalKey<CartScreenState>();
  final Color inActiveIconColor = Color(0xFFB6B6B6);

  int numberOfItems = 0;
  int numberOfIAddress = 0;
  String user_key;
  List<dynamic> keys = [];
  List<dynamic> addressmap = [];
  String authkey = '';
  List<String> addresses = [];
  var addressMapFinal = Map();
  var CurrentAddress;

  Future<void> getCartNumber() async {
    ProductServices _services = ProductServices();
    var favref = await _services.cart.doc(user_key).get();
    keys = favref["cartItems"];
    numberOfItems = keys.length;
    setState(() {});
  }

  Future<void> getuseraddress() async {
    UserServices _services = UserServices();
    var user = await _services.getUserById(authkey);
    addressmap = user["address"];
    numberOfIAddress = addressmap.length;
    for (var address in addressmap) {
      var stringaddress =
          '${address["adline1"]}, ${address["adline2"]}, ${address["city"]}-${address["pincode"].toString()} ';
      addresses.add(stringaddress);
      addressMapFinal[stringaddress] = address;
    }
    selectedKey = addresses[0];
    CurrentAddress = addressmap[0];
    addresses.add("Add new Address");
    setState(() {});
  }

  @override
  void initState() {
    authkey = UserSimplePreferences.getAuthKey() ?? '';
    if (authkey != "") {
      user_key = AuthProvider().user.uid;
      getCartNumber();
      getuseraddress();
    }

    super.initState();
  }

  String selectedKey = '';

  @override
  Widget build(BuildContext context) {
    final Widget normalChildButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      width: SizeConfig.screenWidth * 0.6,
      height: getProportionateScreenHeight(65),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
            left: getProportionateScreenHeight(10),
            right: getProportionateScreenHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Text(
                  selectedKey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                  ),
                )),
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

    if (authkey != "") {
      getCartNumber();
    }
    function(value, boo) {
      widget.func(value, boo);
    }

    _navigateAndDisplaySelection(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Address()),
      );

      if (result) {
        await getuseraddress();
        setState(() {
          final snackBar = SnackBar(
            content: Text('Address Added Successfully'),
            backgroundColor: kPrimaryColor,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    }

    return Padding(
      padding:
      EdgeInsets.only(right: getProportionateScreenHeight(20),left: getProportionateScreenHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ 
          Container(height: getProportionateScreenHeight(100),child: Image(image: AssetImage('assets/images/splash_1.png'))),
          SizedBox(width: getProportionateScreenHeight(15),),
          widget.address == false
              ? SearchField(
            simplebutton: widget.simplebutton,
            func: function,
          )
              : Container(
            width: SizeConfig.screenWidth * 0.75,
            height: getProportionateScreenHeight(65),
            child: MenuButton<String>(
              menuButtonBackgroundColor: Colors.transparent,
              decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(
                      0.1), //border: Border.all(color: Colors.grey[300]!),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              child: normalChildButton,
              items: addresses,
              itemBuilder: (String value) => Container(
                color: kSecondaryColor.withOpacity(0.1),
                height: getProportionateScreenHeight(65),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(10)),
                child: Text(value,
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(13)),
                    overflow: TextOverflow.ellipsis),
              ),
              toggledChild: Container(
                child: normalChildButton,
              ),
              onItemSelected: (String value) {
                setState(() {
                  if (value == addresses[addresses.length - 1]) {
                    _navigateAndDisplaySelection(context);
                  } else {
                    selectedKey = value;
                    CurrentAddress = addressMapFinal[selectedKey];
                  }
                });
                var x = myCartScreenState.currentState.user_key;
                print(x);
              },
              onMenuButtonToggle: (bool isToggle) {
                print(isToggle);
              },
            ),
          ),
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",height: getProportionateScreenHeight(25),
                color: MenuState.home == widget.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () {
                if(MenuState.home == widget.selectedMenu){

                }
                else{
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }

              }),
          SizedBox(width: getProportionateScreenHeight(15),),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",height: getProportionateScreenHeight(25),
              color: MenuState.favourite == widget.selectedMenu
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () {
              if(MenuState.favourite == widget.selectedMenu){

              }
              else{
                if (authkey == '') {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                } else {
                  Navigator.pushNamed(context, LikedScreen.routeName);
                }
              }

            },
          ),
          SizedBox(width: getProportionateScreenHeight(15),),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Chat bubble Icon.svg",height: getProportionateScreenHeight(25),
              color: MenuState.message == widget.selectedMenu
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () {
              if(MenuState.message == widget.selectedMenu){

              }
              else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComingSoon(value: "Ticketing Service",bottomNavigation: true,)),
                );
              }

            },
          ),
          SizedBox(width: getProportionateScreenHeight(15),),
          numberOfItems == 0
              ? IconBtnWithCount(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () {
              if (authkey == '') {
                Navigator.pushNamed(context, SignInScreen.routeName);
              } else {
                if (numberOfIAddress != 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreen(
                            address: CurrentAddress,
                            key: myCartScreenState,
                          )));
                  // Navigator.pushNamed(context, CartScreen.routeName);
                } else {
                  _navigateAndDisplaySelection(context);
                }
              }
            },
          )
              : IconBtnWithCount(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: numberOfItems,
            press: () {
              if (authkey == '') {
                Navigator.pushNamed(context, SignInScreen.routeName);
              } else {
                if (numberOfIAddress != 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreen(
                            address: CurrentAddress,
                            key: myCartScreenState,
                          )));
                  // Navigator.pushNamed(context, CartScreen.routeName);
                } else {
                  _navigateAndDisplaySelection(context);
                }
              }
            },
          ),
          SizedBox(width: getProportionateScreenHeight(15),),
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",height: getProportionateScreenHeight(25),
                color: MenuState.profile == widget.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () {
                if(MenuState.profile == widget.selectedMenu){

                }
                else{
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                }
              }),


          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfitem: 3,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}


class IconBtn extends StatelessWidget {
  const IconBtn({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(12)),
        height: getProportionateScreenHeight(46),
        width: getProportionateScreenHeight(46),
        // decoration: BoxDecoration(
        //   color: kSecondaryColor.withOpacity(0.1),
        //   shape: BoxShape.circle,
        // ),
        child: SvgPicture.asset(svgSrc),
      ),
    );
  }
}


class IconBtnWithCount extends StatelessWidget {
  const IconBtnWithCount({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(12)),
            height: getProportionateScreenHeight(46),
            width: getProportionateScreenHeight(46),
            // decoration: BoxDecoration(
            //   color: kSecondaryColor.withOpacity(0.1),
            //   shape: BoxShape.circle,
            // ),
            child: SvgPicture.asset(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenHeight(16),
                width: getProportionateScreenHeight(16),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

