
import 'dart:convert';

import 'package:bookbuddy/Model/product_model.dart';
import 'package:bookbuddy/Network/middleware.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/Utils/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//
class ProductNotifier extends ChangeNotifier {
  final MiddleWare _authenticationService = service<MiddleWare>();
  RequestState _state = RequestState.Busy;

  RequestState get state => _state;

  List<Product> _products = [];

  List<Product> get products => _products;

  void setState(RequestState state) {
    _state = state;
    notifyListeners();
  }

  void notify() => notifyListeners();

  Future<dynamic> getProductCategory(int category) async {
    setState(RequestState.Busy);
    /*final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');
    debugPrint('token is $token');*/
    http.Response _response = await _authenticationService.getProductCategory(category);

    if (_response != null) {
      var parsed = json.decode(_response.body);
      Iterable iterable = parsed['items'];
//      Data.showResponseMessage(parsed['message']);
      _products = iterable.map((e) => Product.fromJson(e)).toList();
      _products.forEach((element) {debugPrint(element.title);});
      setState(RequestState.Idle);
      debugPrint(state.toString());
      notify();

    }
    setState(RequestState.Idle);

  }
}
