import 'package:testcart/Utils/data.dart';
import 'package:testcart/ViewModel/favorite_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  FavoriteNotifier notifier;

  final textTheme = TextStyle(
      color: Colors.blueGrey.shade900, fontFamily: fFamily, fontSize: 12);

  @override
  void initState() {

    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifier.getFavoriteProductsId();
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<FavoriteNotifier>(
        builder: (context, model, _){
          notifier = model;
          if(model.state == RequestState.Idle){
            return GridView.count(
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                children: model.products.map((e){
                  return Card(
                    shadowColor: Colors.black26,
                    elevation: 10,
                    child: Container(
                      width: screen.height * 0.18,
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
                              getLikeButton(theme.accentColor , model.products.contains(e))),
                          Positioned(
                            top: 25,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Image.network(
                                  e.images,
                                  fit: BoxFit.fitHeight,
                                  height: screen.height * 0.1,
                                  width: screen.height * 0.14,
                                ),
                                SizedBox(height: 2,),
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
                }).toList(),
            );
          }else{
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget getLikeButton(Color color, bool isLiked) {
    return LikeButton(
      size: 20,
      isLiked: isLiked,
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
