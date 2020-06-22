import 'dart:convert';
import 'dart:io';

import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Network/error_handling.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/noted/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NoteAPI {
  final _baseURL = 'https://zuko.eu-gb.mybluemix.net/';

  Future<dynamic> login(Map user) async {
    http.Response _response;
    try {
      _response = await http
          .post('https://qikert.herokuapp.com/' + "user/login", body: user);
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
      _response = await http.post(_baseURL + "product",
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
      _response = await http.post(_baseURL + "product",
          headers: {"Accept": "application/json"}, body: jsonEncoded);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<http.Response> getAllNotes(String token) async {
    http.Response _response;
    try {
      _response = await http.get(_baseURL + "notes",
          headers: {HttpHeaders.authorizationHeader: 'token $token'});
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<http.Response> getProductCategory(List<int> category) async {
    http.Response _response;
    try {
      final jsonEncoded = json.encode({"Query": 'category', "Value": category});
      debugPrint(jsonEncoded);
      _response = await http.post(
        _baseURL + "product",
        body: jsonEncoded,
      );
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<http.Response> addFavorite(final Product product) async {
    http.Response _response;
    try {
      final productJson = json.encode(product);
      _response = await http.post(_baseURL + "product",
          body: productJson);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<http.Response> updateNote(
    String token,
    final note,
  ) async {
    http.Response _response;
    try {
      _response = await http.put(_baseURL + "notes/${note['id']}",
          headers: {HttpHeaders.authorizationHeader: 'token $token'},
          body: note);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<http.Response> delete(String token, String noteId) async {
    http.Response _response;
    try {
      _response = await http.delete(_baseURL + "notes/$noteId",
          headers: {HttpHeaders.authorizationHeader: 'token $token'});
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
