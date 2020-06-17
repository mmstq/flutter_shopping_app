import 'package:bookbuddy/UI/cart_page.dart';
import 'package:bookbuddy/UI/favorite.dart';
import 'package:bookbuddy/UI/homepage.dart';
import 'package:bookbuddy/UI/user_profile.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/Utils/service.dart';
import 'package:bookbuddy/ViewModel/login_notifier.dart';
import 'package:bookbuddy/ViewModel/notes_fetch_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final textTheme =
      TextStyle(color: Color(0xFF455A64), fontFamily: fFamily, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    height = _screen.height;
    width = _screen.width;
    return Scaffold(
      
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, value){
            return [
              SliverAppBar(
                actions: <Widget>[IconButton(icon: Icon(Icons.search),onPressed: (){},)],
                pinned: true,
                floating: true,
                title: Text("TestCart"),
                bottom: TabBar(
                  indicatorWeight: 3,
                  labelPadding: EdgeInsets.only(bottom: 10, top: 10),
                  tabs: <Widget>[
                    Icon(Icons.home),
                    Icon(Icons.shopping_cart),
                    Icon(Icons.favorite),
                    Icon(Icons.person),

                  ],
                ),
              )
            ];
          },
          body: MultiProvider(
            providers: [
              Provider<LoginNotifier>(builder: (_)=>service<LoginNotifier>(),),
              Provider<ProductNotifier>(builder: (_)=>service<ProductNotifier>(),),
            ],
            child: TabBarView(
              children: <Widget>[
                HomePage(),
                Cart(),
                Favorite(),
                UserProfile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
