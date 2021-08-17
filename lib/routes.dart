import 'package:flutter/widgets.dart';
import 'package:orev/screens/Order_Details/order_details.dart';
import 'package:orev/screens/address/address.dart';
import 'package:orev/screens/cart/cart_screen.dart';
import 'package:orev/screens/help_center/help_center.dart';
import 'package:orev/screens/help_form/help_form.dart';
import 'package:orev/screens/liked_item/like_screen.dart';
import 'package:orev/screens/complete_profile/complete_profile_screen.dart';
import 'package:orev/screens/details/details_screen.dart';
import 'package:orev/screens/forgot_password/forgot_password_screen.dart';
import 'package:orev/screens/forgot_password/update_password_screen.dart';
import 'package:orev/screens/home/home_screen.dart';
import 'package:orev/screens/login_success/login_success_screen.dart';
import 'package:orev/screens/my_account/my_account.dart';
import 'package:orev/screens/otp/otp_screen.dart';
import 'package:orev/screens/profile/profile_screen.dart';
import 'package:orev/screens/seemore/seemore.dart';
import 'package:orev/screens/sign_in/sign_in_screen.dart';
import 'package:orev/screens/splash/splash_screen.dart';
import 'package:orev/screens/wallet/wallet.dart';
import 'package:orev/screens/your_order/components/your_order_detail.dart';
import 'package:orev/screens/your_order/your_order.dart';

import 'screens/category_page/category_page.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),//done ui
  SignInScreen.routeName: (context) => SignInScreen(),//done ui
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),//done ui
  UpdatePasswordScreen.routeName: (context) => UpdatePasswordScreen(),//not done
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),//done ui
  SignUpScreen.routeName: (context) => SignUpScreen(),//done ui
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),//not done
  // OtpScreen.routeName: (context) => OtpScreen(), no idea where used??
  HomeScreen.routeName: (context) => HomeScreen(),//
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  LikedScreen.routeName: (context) => LikedScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SeeMore.routeName: (context) => SeeMore(),
  Address.routeName: (context) => Address(),
  OrderDetails.routeName: (context) => OrderDetails(),
  YourOrder.routeName: (context) => YourOrder(),
  YourOrderDetail.routeName: (context) => YourOrderDetail(),
  Wallet.routeName: (context) => Wallet(),
  CategoryPage.routeName: (context) => CategoryPage(),
  MyAccount.routeName: (context) => MyAccount(),
  HelpCenter.routeName: (context) => HelpCenter(),
  HelpForm.routeName: (context) => HelpForm(),
};
