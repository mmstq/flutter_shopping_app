import 'dart:convert';
import 'package:bookbuddy/Network/note_api.dart';
import 'package:bookbuddy/Response/login_response.dart';
import 'package:bookbuddy/Utils/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MiddleWare {

  NoteAPI _api = service<NoteAPI>();


  Future<bool> login(Map user) async {
    http.Response userProfile = await _api.login(user);
    final LoginResponse loginResponse = LoginResponse.fromJson(json.decode(userProfile.body));
    SharedPreferences.getInstance().then((value) => value.setString('token', loginResponse.token));
    return userProfile != null;
  }

  Future<http.Response> signup(Map user) async {
    http.Response userProfile = await _api.signUp(user);
    return userProfile;
  }


  Future<http.Response> getAllNotes(String token) async {
    final _response = await _api.getAllNotes(token);
    debugPrint('mw response $_response');
    return _response;
  }

  Future<http.Response> deleteNoteWithId(String token, String id) async {
    final _response = await _api.delete(token, id);
    debugPrint('mw response $_response');
    return _response;
  }

  Future<http.Response> saveNote(String token, final note) async {
    final _response = await _api.saveNote(token, note);
    debugPrint('mw response $_response');
    return _response;
  }
  Future<http.Response> getProductCategory(int category) async {
    final _response = await _api.getProductCategory(category);
    debugPrint('mw response $_response');
    return _response;
  }

}
