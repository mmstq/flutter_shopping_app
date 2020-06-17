import 'package:bookbuddy/UI/detailscreen.dart';
import 'package:bookbuddy/UI/loginUI.dart';
import 'package:bookbuddy/UI/main_screen.dart';
import 'package:bookbuddy/UI/splash_screen.dart';
import 'package:bookbuddy/Utils/service.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Login': (context) => LoginPage(),
        'Buy': (context) => Buy(),
        'Main': (context) => MainScreen(),
        'Splash': (context) => SplashScreen(),
      },
      title: 'BookBuddy',
      theme: ThemeData(
        accentColor: Color(0xFFFFC107),
        primaryColor: Color(0xFFFFC107),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.blueGrey.shade50),
      home: MainScreen(),
    );
  }

}


class CustomPageBuilder<T> extends PageRoute<T> {
  CustomPageBuilder(this.child);

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => null;
  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(seconds: 1);
}
