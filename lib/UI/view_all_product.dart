import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Utils/data.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ViewAll extends StatelessWidget {
  final List<Product> _products;
  final bool isLiked;
  final String _title;
  ViewAll(this._products, this._title, this.isLiked);

  final textTheme = TextStyle(
      color: Colors.blueGrey.shade900, fontFamily: fFamily, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(_title),),
      body: GridView.count(
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        children: _products.map((e){
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
                      getLikeButton(theme.accentColor , _products.contains(e))),
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
      ),
    );
  }
  Widget getLikeButton(Color color, bool isLiked) {
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
