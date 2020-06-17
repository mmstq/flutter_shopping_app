import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/ViewModel/notes_fetch_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class Category {
  var title = "";
  var icon = "";

  Category(this.title, this.icon);
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
      _notifier.getProductCategory(1);
    });
  }

  final textTheme = TextStyle(
      color: Colors.blueGrey.shade900, fontFamily: fFamily, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    final categories = [
      Category('Mobile', 'assets/smartphone.png'),
      Category('Grocery', 'assets/basket.png'),
      Category('Clothes', 'assets/clothes.png'),
      Category('Books', 'assets/book.png'),
      Category('Health Care', 'assets/mask.png'),
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
                              padding:
                              const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CircleAvatar(
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
                                  Text(
                                    e.title,
                                    style:
                                    textTheme.copyWith(fontSize: 12),
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
                  height: screen.height * 0.2,
                  child: (model.products.isNotEmpty)
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.products.length,
                    itemBuilder: (context, index){
                      final e = model.products[index];
                      return Card(
                        shadowColor: Colors.black12,
                        elevation: 10,
                        child: Container(
                          width: screen.height * 0.14,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                  right: 5,
                                  top: 5,
                                  child: getLikeButton(
                                      theme.accentColor)),
                              /*Positioned(
                            top: 5,
                            left: 5,
                            child: Text(
                              "Nike",
                              style: textTheme.copyWith(fontSize: 12),
                            ),
                          ),*/
                              Positioned(
                                top: 15,
                                right: 0,
                                left: 0,
                                child: Image.network(
                                  e.images,
                                  height: screen.height*0.09,
                                  width: 40,
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                child: Container(
                                  width: screen.height*0.13,
                                  child: Text(e.title + '\n',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: textTheme.copyWith(
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w400)),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: '₹${e.mrp}',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            decoration: TextDecoration
                                                .lineThrough,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: '  ₹${e.afterPrice}\n',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: e.discount,
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: Colors
                                                .lightGreenAccent
                                                .shade700,
                                            height: 1.2),
                                      ),
                                      /*TextSpan(
                                        text: ' Off',
                                        style: textTheme.copyWith(fontSize: 14, color: Colors.lightGreenAccent.shade700,height: 1.2
                                        ),
                                      ),*/
                                    ]),
                                  ))
                            ],
                          ),
                        ),
                      );

                    },
                  )
                      : CircularProgressIndicator(
                    strokeWidth: 2,
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
                  height: screen.height * 0.2,
                  child: (model.products.isNotEmpty)
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.products.length,
                    itemBuilder: (context, index){
                      final e = model.products[index];
                      return Card(
                        shadowColor: Colors.black12,
                        elevation: 10,
                        child: Container(
                          width: screen.height * 0.14,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                  right: 5,
                                  top: 5,
                                  child: getLikeButton(
                                      theme.accentColor)),
                              /*Positioned(
                            top: 5,
                            left: 5,
                            child: Text(
                              "Nike",
                              style: textTheme.copyWith(fontSize: 12),
                            ),
                          ),*/
                              Positioned(
                                top: 15,
                                right: 0,
                                left: 0,
                                child: Image.network(
                                  e.images,
                                  height: screen.height*0.09,
                                  width: 40,
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                child: Container(
                                  width: screen.height*0.13,
                                  child: Text(e.title + '\n',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: textTheme.copyWith(
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w400)),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: '₹${e.mrp}',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            decoration: TextDecoration
                                                .lineThrough,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: '  ₹${e.afterPrice}\n',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: e.discount,
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: Colors
                                                .lightGreenAccent
                                                .shade700,
                                            height: 1.2),
                                      ),
                                      /*TextSpan(
                                        text: ' Off',
                                        style: textTheme.copyWith(fontSize: 14, color: Colors.lightGreenAccent.shade700,height: 1.2
                                        ),
                                      ),*/
                                    ]),
                                  ))
                            ],
                          ),
                        ),
                      );

                    },
                  )
                      : CircularProgressIndicator(
                    strokeWidth: 2,
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
                  height: screen.height * 0.2,
                  child: (model.products.isNotEmpty)
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.products.length,
                    itemBuilder: (context, index){
                      final e = model.products[index];
                      return Card(
                        shadowColor: Colors.black12,
                        elevation: 10,
                        child: Container(
                          width: screen.height * 0.14,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                  right: 5,
                                  top: 5,
                                  child: getLikeButton(
                                      theme.accentColor)),
                              /*Positioned(
                            top: 5,
                            left: 5,
                            child: Text(
                              "Nike",
                              style: textTheme.copyWith(fontSize: 12),
                            ),
                          ),*/
                              Positioned(
                                top: 15,
                                right: 0,
                                left: 0,
                                child: Image.network(
                                  e.images,
                                  height: screen.height*0.09,
                                  width: 40,
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                child: Container(
                                  width: screen.height*0.13,
                                  child: Text(e.title + '\n',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: textTheme.copyWith(
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w400)),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: '₹${e.mrp}',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            decoration: TextDecoration
                                                .lineThrough,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: '  ₹${e.afterPrice}\n',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: e.discount,
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: Colors
                                                .lightGreenAccent
                                                .shade700,
                                            height: 1.2),
                                      ),
                                      /*TextSpan(
                                        text: ' Off',
                                        style: textTheme.copyWith(fontSize: 14, color: Colors.lightGreenAccent.shade700,height: 1.2
                                        ),
                                      ),*/
                                    ]),
                                  ))
                            ],
                          ),
                        ),
                      );

                    },
                  )
                      : CircularProgressIndicator(
                    strokeWidth: 2,
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
                  height: screen.height * 0.2,
                  child: (model.products.isNotEmpty)
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.products.length,
                    itemBuilder: (context, index){
                      final e = model.products[index];
                      return Card(
                        shadowColor: Colors.black12,
                        elevation: 10,
                        child: Container(
                          width: screen.height * 0.14,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                  right: 5,
                                  top: 5,
                                  child: getLikeButton(
                                      theme.accentColor)),
                              /*Positioned(
                            top: 5,
                            left: 5,
                            child: Text(
                              "Nike",
                              style: textTheme.copyWith(fontSize: 12),
                            ),
                          ),*/
                              Positioned(
                                top: 15,
                                right: 0,
                                left: 0,
                                child: Image.network(
                                  e.images,
                                  height: screen.height*0.09,
                                  width: 40,
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                child: Container(
                                  width: screen.height*0.13,
                                  child: Text(e.title + '\n',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: textTheme.copyWith(
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w400)),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: '₹${e.mrp}',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            decoration: TextDecoration
                                                .lineThrough,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: '  ₹${e.afterPrice}\n',
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            height: 1.2),
                                      ),
                                      TextSpan(
                                        text: e.discount,
                                        style: textTheme.copyWith(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: Colors
                                                .lightGreenAccent
                                                .shade700,
                                            height: 1.2),
                                      ),
                                      /*TextSpan(
                                        text: ' Off',
                                        style: textTheme.copyWith(fontSize: 14, color: Colors.lightGreenAccent.shade700,height: 1.2
                                        ),
                                      ),*/
                                    ]),
                                  ))
                            ],
                          ),
                        ),
                      );

                    },
                  )
                      : CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getLikeButton(Color color) {
    return LikeButton(
      size: 20,
      circleColor: CircleColor(start: color, end: Colors.deepOrange),
      bubblesColor: BubblesColor(
        dotPrimaryColor: color,
        dotSecondaryColor: Colors.deepOrange,
      ),
      onTap: onTapLikeButton,
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: color,
          size: 20,
        );
      },
    );
  }

  Future<bool> onTapLikeButton(bool isLiked) async {
    return !isLiked;
  }
}
