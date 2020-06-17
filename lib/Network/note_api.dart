import 'dart:io';
import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/noted/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bookbuddy/Network/error_handling.dart';

class NoteAPI
{
  final _baseURL = 'https://zuko.eu-gb.mybluemix.net/';

  Future<dynamic> login(Map user) async {
    http.Response _response;
    try {
      _response = await http.post(_baseURL + "user/login", body: user);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<dynamic> signUp(Map user) async {
    http.Response _response;
    try {
      _response = await http.post(_baseURL + "user/signup", body: user);
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
  Future<http.Response> getProductCategory(int category) async {
    http.Response _response;
    try {
      _response = await http.get(_baseURL + "product?category=$category");
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }

  Future<http.Response> saveNote(String token, final note) async {
    http.Response _response;
    try {
      _response = await http.post(_baseURL + "notes",
          headers: {HttpHeaders.authorizationHeader: 'token $token'}, body: note);
      _response = _responseCheck(_response);
    } on SocketException {
      throw FetchDataException("Not connected to internet");
    }
    return _response;
  }
  Future<http.Response> updateNote(String token, final note,) async {
    http.Response _response;
    try {
      _response = await http.put(_baseURL + "notes/${note['id']}",
          headers: {HttpHeaders.authorizationHeader: 'token $token'}, body: note);
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
        debugPrint('response ${response.body}');
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
