import 'package:json_annotation/json_annotation.dart';

class LoginResponse {
  String message;
  String token;
  User user;

  LoginResponse({this.message, this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
@JsonSerializable()
class User {
  List<int> favorite = [];
  List<Address> address = [];
  String joined;
  String email;
  String username;
  String name;

  @JsonKey(name: '_id')
  String id;

  User({this.favorite,this.address, this.joined, this.email, this.username, this.name});

  User.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = new List<Address>();
      json['address'].forEach((v) {
        address.add(new Address.fromJson(v));
      });
    }
    if (json['favorites'] != null) {
      favorite = json['favorites'].cast<int>();

    }
    id = json['_id'];
    joined = json['joined'];
    email = json['email'];
    username = json['username'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favorites'] = this.favorite;
    data['joined'] = this.joined;
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['name'] = this.name;
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Address {
  String street;
  String phone;
  String district;
  String state;
  String pIN;

  Address({this.street, this.phone, this.district, this.state, this.pIN});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['Street'];
    phone = json['Phone'];
    district = json['District'];
    state = json['State'];
    pIN = json['PIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Street'] = this.street;
    data['Phone'] = this.phone;
    data['District'] = this.district;
    data['State'] = this.state;
    data['PIN'] = this.pIN;
    return data;
  }
}
