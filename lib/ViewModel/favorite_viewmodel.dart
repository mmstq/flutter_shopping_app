import 'dart:convert';

import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Network/middleware.dart';
import 'package:testcart/Response/login_response.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/Utils/service.dart';
import 'package:flutter/material.dart';

class FavoriteNotifier extends ChangeNotifier {
  final MiddleWare _middleware = service<MiddleWare>();

  List<Product> _products = [];

  List<Product> get products => _products;

  User user = new User();
  RequestState _state = RequestState.Idle;

  RequestState get state => _state;

  void setState(RequestState state) {
    _state = state;
    notifyListeners();
  }

  Future<dynamic> getFavoriteProductsId() async {
    setState(RequestState.Busy);

    Map userObject = json.decode(sharedPreference.getString('user') ?? "{}");
    user = User.fromJson(userObject);
    getFavoriteProductList(user.favorite);
  }

  Future<dynamic> getFavoriteProductList(List<int> products) async {
    setState(RequestState.Busy);
    final _response = await _middleware.getProductWithId(products);
    var parsed = json.decode(_response.body);
    Iterable iterable = parsed['items'];
    _products = iterable.map((e) => Product.fromJson(e)).toList();
    setState(RequestState.Idle);
  }

  Future<dynamic> updateFavorites(List<int> products) async {
    setState(RequestState.Busy);
    final _response = await _middleware.getProductWithId(products);
    var parsed = json.decode(_response.body);
    Iterable iterable = parsed['items'];
    _products = iterable.map((e) => Product.fromJson(e)).toList();
    setState(RequestState.Idle);
  }
}
