import 'package:flutter/material.dart';

void showNow(BuildContext context) {

  Widget okButton = Container(
    width: 60,
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.green.shade600, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      color: Color(0xE276FF03),
      child: Icon(
        Icons.check,
        color: Colors.green.shade600,
      ),
      onPressed: () {

      },
    ),
  );
  Widget cancelButton = Container(
    width: 60,
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.red.shade900, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      color: Colors.red,
      child: Icon(
        Icons.close,
        color: Colors.red.shade900,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );

  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {},
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.4),
    barrierLabel: '',
    transitionDuration: Duration(milliseconds: 150),
    transitionBuilder: (context, anim1, anim2, child) {
      final curves = CurvedAnimation(parent: anim1, curve: Curves.bounceInOut, reverseCurve: Curves.easeInCubic);
      return Transform.scale(
        scale: curves.value,
        child: AlertDialog(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 5,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.deepOrangeAccent,
                        size: 35,
                      ),
                      radius: 23,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width:20,
                  ),
                  Text("Sign Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "TitilliumWeb",
                          fontWeight: FontWeight.w600,
                          fontSize: 20)),
                ],
              ),
              SizedBox(height: 30,),
              Text(
                "Do you want to sign out ?",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "TitilliumWeb",
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  cancelButton,
                  SizedBox(width: 10,),
                  okButton
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
