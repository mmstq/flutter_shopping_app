import 'package:testcart/Model/product_model.dart';
import 'package:testcart/Network/note_api.dart';
import 'package:testcart/Utils/service.dart';
import 'package:http/http.dart' as http;

class MiddleWare {

  NoteAPI _api = service<NoteAPI>();


  Future<http.Response> login(Map user) async {
    http.Response userProfile = await _api.login(user);
    return userProfile;
  }
/*
  Future<http.Response> signUp(Map user) async {
    http.Response userProfile = await _api.signUp(user);
    return userProfile;
  }*/


  Future<http.Response> getProductWithId(List<int> products) async {
    final _response = await _api.getProductWithId(products);
    return _response;
  }
  Future<http.Response> updateFavorites(List<int> products) async {
    final _response = await _api.getProductWithId(products);
    return _response;
  }

  Future<http.Response> deleteNoteWithId(String token, String id) async {
    final _response = await _api.delete(token, id);
    return _response;
  }

  Future<http.Response> addFavorite(final Product product) async {
    final _response = await _api.addFavorite(product);
    return _response;
  }
  Future<http.Response> getProductCategory(List<int> category) async {
    final _response = await _api.getProductCategory(category);
    return _response;
  }

}
