import 'dart:convert';
import 'package:testcart/Network/middleware.dart';
import 'package:testcart/Model/login_response.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/Utils/service.dart';
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  final MiddleWare _middleware = service<MiddleWare>();

  RequestState _state = RequestState.Idle;
  bool _isSignedIn = false;

  RequestState get state => _state;

  bool get isSignedIn => _isSignedIn;

  void setState(RequestState state) {
    _state = state;
    notifyListeners();
  }

  void setSigned(bool value, String uid) {
    _isSignedIn = value;
    sharedPreference.setString('uid', uid);
    if (_isSignedIn != value) notifyListeners();
  }

  Future<dynamic> login(Map user) async {
    setState(RequestState.Busy);
    try {
      final response = await _middleware.login(user);
      debugPrint(response.body);
      final LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(response.body));
      Map us = loginResponse.user.toJson();

      sharedPreference.setString('token', loginResponse.token);
      sharedPreference.setString('user', json.encode(us));

      final bool success = response.statusCode == 202;
      debugPrint('is login successful $success');
      if (success) {
        setState(RequestState.Done);
        setSigned(true, loginResponse.user.id);
      } else {
        setState(RequestState.Idle);
      }
    } catch (e) {
      debugPrint('caught exception $e');
      setState(RequestState.Idle);
    }
  }
}
