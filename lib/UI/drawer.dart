//import 'package:bookbuddy/UI/caution_dialog.dart';
//import 'package:bookbuddy/Utils/data.dart';
//import 'package:flutter/material.dart';
//
//class DrawerMenu extends StatelessWidget {
//  final menuItemsStyle = TextStyle(
//      color: Colors.white,
//      fontSize: 17,
//      fontFamily: fFamily,
//      fontWeight: FontWeight.w300);
//
//  @override
//  Widget build(BuildContext context) {
//    return SizedBox(
//      width: width * 0.65,
//      child: Drawer(
//        child: Container(
//          width: 10,
//          color: Color(0xFF1c2b3d),
//          child: new Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            mainAxisSize: MainAxisSize.max,
//            children: <Widget>[
//              Container(
//                height: height * .28,
//                child: new DrawerHeader(
//                  padding: EdgeInsets.all(0),
//                  margin: EdgeInsets.all(0),
//                  child: new Image.asset(
//                    'assets/header.jpg',
//                    fit: BoxFit.fill,
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 10,
//              ),
//              new ListTile(
//                leading: Image.asset(
//                  'assets/home.png',
//                  width: 30,
//                ),
//                title: new Text(
//                  'Home',
//                  style: menuItemsStyle,
//                ),
//                onTap: () {},
//              ),
//              new Divider(),
//              new ListTile(
//                leading: Image.asset(
//                  'assets/click.png',
//                  width: 30,
//                ),
//                title: new Text(
//                  'Click Me',
//                  style: menuItemsStyle,
//                ),
//                onTap: () {
//                  showCautionDialog(context);
//                },
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
