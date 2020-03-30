import 'dart:convert';

import 'package:event_sg/globals/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Login {

  static final Login _login = Login._internal();
  // TODO: change this!
  String _userId = "3b41e41f-1b4b-4708-98ec-28145d2c4e6a"; // change to ""
  bool _isLoggedIn = true; // change to false

  factory Login() {
    return _login;
  }

  Login._internal();

  /// Changes the userId based on http response if the user is found.
  /// Else, throw an error.
  logIn({@required String email, @required String password}) async {
    final url = "${Urls.apiUrlBase}/user/login/$email/$password";
    final response = await http.get(url);
    String userId = jsonDecode(response.body);
    print(userId);

    if (userId.length == Uuid().v4().length) {
      _isLoggedIn = true;
      print("Logged in!");
    } else {
      throw("Authentication Failed!");
    }

  }

  /// Changes the login status to false.
  logOut() {
    if (_isLoggedIn) {
      this._isLoggedIn = false;
    } else {
      throw ("Error: user not logged in!");
    }
  }

  /// Returns the userId if the user is logged in.
  String getUserId() {
    if (_isLoggedIn) {
      return _userId;
    } else {
      throw("Error: user not logged in!");
    }
  }

}