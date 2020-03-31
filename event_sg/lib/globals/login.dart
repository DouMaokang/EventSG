import 'dart:convert';

import 'package:event_sg/globals/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Login {

  static final Login _login = Login._internal();
  // TODO: change this!

  // String _userId = "4a37270f-10ff-45fc-b407-debfc9256ecd"; // change to ""


   String _userId = "d79595a8-412c-46ad-9bf6-043015e947fd"; // change to ""

  bool _isLoggedIn = true; // change to false


  factory Login() {
    return _login;
  }

  Login._internal();

  /// Changes the userId based on http response if the user is found.
  /// Else, throw an error.
  Future<bool> logIn({@required String email, @required String password}) async {
    final url = "${Urls.apiUrlBase}/user/login/$email/$password";
    final response = await http.get(url);
    String userId = jsonDecode(response.body);
    print(userId);

    if (userId.length == Uuid().v4().length) {
      _isLoggedIn = true;
      print("Logged in!");
      return true;
    } else {
      print("Login failed!");
      return false;
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
