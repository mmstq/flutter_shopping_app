import 'package:testcart/Utils/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcart/UI/cart_page.dart';
import 'package:testcart/UI/favorite.dart';
import 'package:testcart/UI/homepage.dart';
import 'package:testcart/UI/search_country.dart';
import 'package:testcart/UI/user_profile.dart';
import 'package:testcart/Utils/service.dart';
import 'package:testcart/ViewModel/favorite_viewmodel.dart';
import 'package:testcart/ViewModel/notes_fetch_notifier.dart';

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
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                actions: <Widget>[
                  IconButton(
                      splashColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: SearchByCountry(products));
                      })
                ],
                pinned: true,
                floating: true,
                title: Row(
                  children: <Widget>[
                    Image.asset(
                      'icon/icon.png',
                      height: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "TestCart",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
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
              ChangeNotifierProvider<ProductNotifier>(
                create: (_) => service<ProductNotifier>(),
              ),
              ChangeNotifierProvider<FavoriteNotifier>(
                create: (_) => service<FavoriteNotifier>(),
              ),
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
