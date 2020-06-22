import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDark = true;
String userUID;
String phone = "+917011152375";
final fFamily = "Ubuntu";
double height = 0;
double width = 0;
SharedPreferences sharedPreference;
String verificationId;
final phoneHelperText = "Enter number w/o +91";
final loginDescription = "TestCart is your online store for Mobiles, Fashion, Electronics, Home Appliances, Books, Home, Furniture, Grocery, Jewelry, Sporting goods and much more";


enum RequestState {Busy, Idle, Done}

class Data{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext buildContext;

  static Route routeSwitcher(BuildContext context, Widget pageToGo) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondAnimation) => pageToGo,
        transitionDuration: Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final animation1 = animation.drive(tween);
          return SlideTransition(
            child: child,
            position: animation1,
          );
        });
  }
}

