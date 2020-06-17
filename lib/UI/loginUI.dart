import 'package:bookbuddy/UI/main_screen.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/noted/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final textTheme = TextStyle(color: Color(0xFF455A64), fontFamily: fFamily, fontSize: 25);

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    height = _screen.height;
    width = _screen.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: height/2.8,
              right: 0,
              left: 0,
              child: Container(
                child: Image.asset('icon/icon.png',height: height * 0.15),
              ),
            ),
            Positioned(
              bottom: height/3.5,
              right: 0,
              left: 0,
              child: Container(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textTheme,
                    children: [
                      TextSpan(
                        style: textTheme.copyWith(fontSize: 25, fontWeight: FontWeight.w300),
                        text: "Welcome to\n"
                      ),TextSpan(
                        style: textTheme.copyWith(fontSize: 25  , fontWeight: FontWeight.w500),
                        text: "TestCart "
                      ),TextSpan(
                        style: textTheme.copyWith(fontSize: 25  , fontWeight: FontWeight.w300),
                        text: "Shopping"
                      ),
                    ]
                  ),
                )
              ),
            ),

            Positioned(
              bottom: height/5,
              child: RaisedButton(
                splashColor: theme.accentColor,
                shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 0,
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(Data.routeSwitcher(context, LoginApp()), (route) => false);

                },
                child: Container(
                  height: 40,
                  width: 130,

                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontFamily: fFamily, fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height/7.5,
              child: OutlineButton(
                highlightedBorderColor: theme.accentColor,
                color: theme.accentColor,
                shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(Data.routeSwitcher(context, MainScreen()), (route) => false);
                },
                child: Container(
                  height: 38,
                  width: 130,
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontFamily: fFamily, fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
