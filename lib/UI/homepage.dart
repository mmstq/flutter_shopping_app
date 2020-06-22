import 'dart:convert';

import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Model/login_response.dart';
import 'package:testcart/UI/detailscreen.dart';
import 'package:testcart/UI/view_all_product.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/ViewModel/notes_fetch_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class Category {
  var title = "";
  var icon = "";
  int category;

  Category(this.title, this.icon, this.category);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductNotifier _notifier;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _notifier.setState(RequestState.Busy);
      _notifier.getProductCategory(2);
    });
  }



  final textTheme = TextStyle(
      color: Colors.blueGrey.shade900, fontFamily: fFamily, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    final categories = [
      Category('Mobile', 'assets/smartphone.png',2),
      Category('Clothes', 'assets/clothes.png',4),
      Category('Books', 'assets/book.png',3),
      Category('Shoes', 'assets/shoe.png',1),
      Category('Health Care', 'assets/mask.png',5),
    ];
    final theme = Theme.of(context);
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Consumer<ProductNotifier>(
          builder: (context, model, child) {
            _notifier = model;
            return Column(
              children: <Widget>[
                Container(
                  height: screen.height * 0.2,
                  width: screen.width,
                  child: Card(
                    shadowColor: Colors.black26,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Text(
                            "All Categories",
                            style: textTheme.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: screen.height * 0.14,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categories
                                .map((e) => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 0, 12, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              var list;
                                              switch(e.category){
                                                case 1:
                                                  list = model.one;
                                                  break;
                                                case 2:
                                                  list = model.two;
                                                  break;
                                                case 3:
                                                  list = model.three;
                                                  break;
                                                default:
                                                  list = model.four;
                                                  break;
                                              }
                                              showAll(list, e.title, false);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: theme.accentColor
                                                  .withOpacity(0.2),
                                              radius: 32,
                                              child: Image.asset(
                                                e.icon,
                                                color: theme.accentColor,
                                                height: 25,
                                                width: 25,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            e.title,
                                            style: textTheme.copyWith(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Deals on shoes",
                        style: textTheme.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    GestureDetector(
                        onTap: ()=>showAll(model.one, 'Shoes', false),
                        child: Text(
                      'view all',
                      style: textTheme,
                    )),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    height: screen.height * 0.24,
                    child: (model.one.isNotEmpty)
                        ? ListView.builder(
                            padding: EdgeInsets.only(bottom: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              final e = model.one[index];
                              return Card(
                                shadowColor: Colors.black26,
                                elevation: 10,
                                child: Container(
                                  width: screen.height * 0.15,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                bottomRight:
                                                    Radius.circular(4)),
                                            color: Colors
                                                .lightGreenAccent.shade700,
                                          ),
                                          child: Text(e.discount,
                                              style: textTheme.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  height: 1.2)),
                                        ),
                                      ),
                                      Positioned(
                                          right: 3,
                                          top: 3,
                                          child:
                                              getLikeButton(theme.accentColor, e)),
                                      Positioned(
                                        top: 25,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2, bottom: 5),
                                              child: GestureDetector(
                                                onTap: ()=>Navigator.of(context).push(Data.routeSwitcher(context, DetailedScreen(e))),
                                                child: Hero(
                                                  tag: e.productId.toString(),
                                                  child: Image.network(
                                                    e.images,
                                                    fit: BoxFit.fitHeight,
                                                    height: screen.height * 0.1,
                                                    width: screen.height * 0.14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: screen.height * 0.14,
                                              child: Text(e.title + '\n',
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: textTheme.copyWith(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400)),
                                            ),
                                            RichText(
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: '₹${e.mrp}',
                                                  style: textTheme.copyWith(
                                                      fontSize: 13,
                                                      height: 1.5,
                                                      decoration: TextDecoration
                                                          .lineThrough,),
                                                ),
                                                TextSpan(
                                                  text: '  ₹${e.afterPrice}\n',
                                                  style: textTheme.copyWith(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700),
                                                ),

                                              ]),

                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            ),
                          )),

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Deals on mobiles",
                        style: textTheme.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    GestureDetector(
                        onTap: ()=>showAll(model.two, 'Mobiles', false),
                        child: Text(
                          'view all',
                          style: textTheme,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    height: screen.height * 0.24,
                    child: (model.two.isNotEmpty)
                        ? ListView.builder(
                      padding: EdgeInsets.only(bottom: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final e = model.two[index];
                        return Card(
                          shadowColor: Colors.black26,
                          elevation: 10,
                          child: Container(
                            width: screen.height * 0.15,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          bottomRight:
                                          Radius.circular(4)),
                                      color: Colors
                                          .lightGreenAccent.shade700,
                                    ),
                                    child: Text(e.discount,
                                        style: textTheme.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,)),
                                  ),
                                ),
                                Positioned(
                                    right: 3,
                                    top: 3,
                                    child:
                                    getLikeButton(theme.accentColor, e)),
                                Positioned(
                                  top: 25,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2, bottom: 5),
                                        child: Image.network(
                                          e.images,
                                          fit: BoxFit.fitHeight,
                                          height: screen.height * 0.095,
                                          width: screen.height * 0.14,
                                        ),
                                      ),
                                      Container(
                                        width: screen.height * 0.14,
                                        child: Text(e.title + '\n',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: textTheme.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      SizedBox(height: 2,),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '₹${e.mrp}',
                                            style: textTheme.copyWith(
                                              fontSize: 13,
                                              height: 1.2,
                                              decoration: TextDecoration
                                                  .lineThrough,),
                                          ),
                                          TextSpan(
                                            text: '  ₹${e.afterPrice}\n',
                                            style: textTheme.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),

                                        ]),

                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                    )),

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Deals on books",
                        style: textTheme.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    GestureDetector(
                        onTap: ()=>showAll(model.three, 'Books', false),
                        child: Text(
                          'view all',
                          style: textTheme,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    height: screen.height * 0.24,
                    child: (model.three.isNotEmpty)
                        ? ListView.builder(
                      padding: EdgeInsets.only(bottom: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final e = model.three[index];
                        return Card(
                          shadowColor: Colors.black26,
                          elevation: 10,
                          child: Container(
                            width: screen.height * 0.15,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          bottomRight:
                                          Radius.circular(4)),
                                      color: Colors
                                          .lightGreenAccent.shade700,
                                    ),
                                    child: Text(e.discount,
                                        style: textTheme.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            height: 1.2)),
                                  ),
                                ),
                                Positioned(
                                    right: 3,
                                    top: 3,
                                    child:
                                    getLikeButton(theme.accentColor, e)),
                                Positioned(
                                  top: 25,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2, bottom: 5),
                                        child: Image.network(
                                          e.images,
                                          fit: BoxFit.fitHeight,
                                          height: screen.height * 0.1,
                                          width: screen.height * 0.14,
                                        ),
                                      ),
                                      Container(
                                        width: screen.height * 0.14,
                                        child: Text(e.title + '\n',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: textTheme.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '₹${e.mrp}',
                                            style: textTheme.copyWith(
                                              fontSize: 13,
                                              height: 1.5,

                                              decoration: TextDecoration
                                                  .lineThrough,),
                                          ),
                                          TextSpan(
                                            text: '  ₹${e.afterPrice}\n',
                                            style: textTheme.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),

                                        ]),

                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                    )),

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Deals on clothes",
                        style: textTheme.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(
                      flex: 20,
                    ),
                    GestureDetector(
                        onTap: ()=>showAll(model.four, 'Clothes', false),
                        child: Text(
                          'view all',
                          style: textTheme,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    height: screen.height * 0.24,
                    child: (model.four.isNotEmpty)
                        ? ListView.builder(
                      padding: EdgeInsets.only(bottom: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final e = model.four[index];
                        return Card(
                          shadowColor: Colors.black26,
                          elevation: 10,
                          child: Container(
                            width: screen.height * 0.15,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          bottomRight:
                                          Radius.circular(4)),
                                      color: Colors
                                          .lightGreenAccent.shade700,
                                    ),
                                    child: Text(e.discount,
                                        style: textTheme.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            height: 1.2)),
                                  ),
                                ),
                                Positioned(
                                    right: 3,
                                    top: 3,
                                    child:
                                    getLikeButton(theme.accentColor, e)),
                                Positioned(
                                  top: 25,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2, bottom: 5),
                                        child: Image.network(
                                          e.images,
                                          fit: BoxFit.fitHeight,
                                          height: screen.height * 0.1,
                                          width: screen.height * 0.14,
                                        ),
                                      ),
                                      Container(
                                        width: screen.height * 0.14,
                                        child: Text(e.title + '\n',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: textTheme.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      SizedBox(height: 2,),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '₹${e.mrp}',
                                            style: textTheme.copyWith(
                                              fontSize: 13,
                                              height: 1.5,
                                              decoration: TextDecoration
                                                  .lineThrough,),
                                          ),
                                          TextSpan(
                                            text: '  ₹${e.afterPrice}\n',
                                            style: textTheme.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),

                                        ]),

                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getLikeButton(Color color, Product product) {
    return LikeButton(
      size: 20,
      circleColor: CircleColor(start: color, end: Colors.deepOrange),
      bubblesColor: BubblesColor(
        dotPrimaryColor: color,
        dotSecondaryColor: Colors.deepOrange,
      ),
      onTap: (bool isLiked) async {

        Map userObject = json.decode(sharedPreference.getString('user')??new User());
        var user = User.fromJson(userObject);
        if(isLiked){
          user.favorite.add(product.productId);
        }else{
          user.favorite.remove(product.productId);
        }
        sharedPreference.setString('user', json.encode(user));

        return !isLiked;
      },
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: color,
          size: 20,
        );
      },
    );
  }


  void showAll(List<Product> products, String title, bool isLiked){
    Navigator.of(context).push(Data.routeSwitcher(context, ViewAll(products, title, isLiked)));

  }
}
