import 'dart:convert';
import 'dart:io';

import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Network/error_handling.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/UI/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NoteAPI {
  final _baseURL = 'https://qikert.herokuapp.com/';

  Future<dynamic> login(Map user) async {
    http.Response _response;
    try {
      _response = await http
          .post(_baseURL + "user/login", body: user);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<dynamic> getProductWithId(List<int> products) async {
    http.Response _response;
    try {
      final jsonEncoded =
      json.encode({"Query": 'product_id', "Value": products});
      _response = await http.post(_baseURL + "products",
          body: jsonEncoded);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<dynamic> updateFavoriteList(List<int> products) async {
    http.Response _response;
    try {
      final jsonEncoded =
          json.encode({"Query": 'product_id', "Value": products});
      _response = await http.post(_baseURL + "products",
          headers: {"Accept": "application/json"}, body: jsonEncoded);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<http.Response> getProductCategory(int category) async {
    http.Response _response;
    try {
      final jsonEncoded = json.encode({"Query": 'category', "Value": category});
      debugPrint(jsonEncoded);
      _response = await http.post(
        _baseURL + "products/category",
        body: jsonEncoded,
      );
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }



  dynamic _responseCheck(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
//        debugPrint('response ${response.body}');
        return response;

      case 400:
        throw BadRequestException(response.body.toString());

      case 401:

      case 403:
        switchActivity();
        break;

      case 500:
        throw IntervalServerException();

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  void switchActivity() {
    Data.navigatorKey.currentState.pushAndRemoveUntil(
        Data.routeSwitcher(Data.navigatorKey.currentContext, LoginApp()),
        (route) => false);
  }
}
