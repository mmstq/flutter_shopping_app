import 'package:bookbuddy/Network/middleware.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/Utils/service.dart';
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier{

  final MiddleWare _middleware  = service<MiddleWare>();

  RequestState _state = RequestState.Idle;
  bool _isSignedIn = false;

  RequestState get state => _state;

  bool get isSignedIn => _isSignedIn;

  void setState(RequestState state){
    _state = state;
    notifyListeners();
  }
  void setSigned(bool value){
    _isSignedIn = value;
    if(_isSignedIn != value) notifyListeners();
  }

  Future<dynamic> login(Map user)async{
    setState(RequestState.Busy);
    try{
      final success = await _middleware.login(user);
      debugPrint('is login successful $success');
//      if(success) {
//        setState(RequestState.Done);
//        setSigned(true);
//      }else{
//        setState(RequestState.Idle);
//      }
    }catch(e){
      debugPrint('caught exception $e');
      setState(RequestState.Idle);
    }

  }
}