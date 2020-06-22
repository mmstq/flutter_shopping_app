import 'dart:convert';

import 'package:testcart/Utils/data.dart';
import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Network/middleware.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/Utils/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ProductNotifier extends ChangeNotifier {
  final MiddleWare _authenticationService = service<MiddleWare>();
  RequestState _state = RequestState.Busy;

  RequestState get state => _state;


  List<Product> _one = [];
  List<Product> _two = [];
  List<Product> _three = [];
  List<Product> _four = [];

  List<Product> get one => _one;
  List<Product> get two => _two;
  List<Product> get three => _three;
  List<Product> get four => _four;

  void setState(RequestState state) {
    _state = state;
    notifyListeners();
  }

  void notify() => notifyListeners();

  Future<dynamic> getProductCategory(int category) async {
    debugPrint(category.toString());
    http.Response _response = await _authenticationService.getProductCategory(category);

    var parsed = json.decode(_response.body);
    Iterable iterable = parsed['items'];
    debugPrint(iterable.toString());
    // sharedPreference.remove('uid');

    if(category == 1){
      _one = iterable.map((e) => Product.fromJson(e)).toList();
      products += _one;
      setState(RequestState.Idle);
      await getProductCategory(2);

    }
    else if(category == 2){
      _two = iterable.map((e) => Product.fromJson(e)).toList();
      products += _two;
      setState(RequestState.Idle);
      await getProductCategory(3);


    }
    else if(category == 3){
      _three = iterable.map((e) => Product.fromJson(e)).toList();
      products += _three;
      setState(RequestState.Idle);
      await getProductCategory(4);


    }else{
      _four = iterable.map((e) => Product.fromJson(e)).toList();
      products += _four;
      setState(RequestState.Idle);

    }

  }
}
