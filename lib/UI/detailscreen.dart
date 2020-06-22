import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/Utils/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getImage(String imageUrl) {

  return FadeInImage.assetNetwork(
      height: height * 0.47,
      width: width,
      fit: BoxFit.fitWidth,
      placeholder: "Loading Image",
      image: imageUrl);
}

class DetailedScreen extends StatelessWidget {
  final Product _product;

  DetailedScreen(this._product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Hero(tag: _product.productId.toString(), child: getImage(_product.images)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1,
              width: width,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 0.2,
                  width: width * 0.85,
                  color: Colors.white,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    _product.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: fFamily,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    _product.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                        fontFamily: fFamily,
                        fontWeight: FontWeight.w300),
                  ),
                ),
               /* RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Address : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: fFamily,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: _docs['address'],
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            fontFamily: fFamily))
                  ]),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "For : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: fFamily,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: _docs['category'],
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            fontFamily: fFamily)),
                    TextSpan(
                        text: "   Sem : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: fFamily,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: _docs['semester'],
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            fontFamily: fFamily))
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),*/
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green,
                      shape: BoxShape.rectangle),
                  child: Text(
                    "  ${_product.afterPrice}  ",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: fFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/call.png',
                      width: 25,
                      height: 20,
                    ),
                    /*Text(
                      "  ${_docs['phone']}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: fFamily),
                    )*/
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





