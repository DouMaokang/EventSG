import 'dart:convert';
import 'dart:core';

import 'package:event_sg/globals/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Login {

  static final Login _login = Login._internal();
  // TODO: change this!
  // yt's String _userId = "8cb99803-e4e9-4955-9c6d-b442b9385b51"; // change to ""
  // String _userId = "4a37270f-10ff-45fc-b407-debfc9256ecd"; // change to ""

  String _userId = "4a37270f-10ff-45fc-b407-debfc9256ecd"; // change to ""

  bool _isLoggedIn = true; // change to false

  String _invalidUSerMsg = "INVALID USER";
  String _wrongPasswordMsg = "WRONG PASSWORD";
  String _successMsg = "SUCCESS";

  factory Login() {
    return _login;
  }

  Login._internal();

  /// Changes the userId based on http response if the user is found.
  /// Else, throw an error.
  Future<bool> logIn({@required String email, @required String password}) async {
    final checkPasswordUrl = "${Urls.apiUrlBase}/user/login/$email/$password";
    final passwordResponse = await http.get(checkPasswordUrl);
    String userId = jsonDecode(passwordResponse.body);
    if (userId.length != Uuid().v4().length) {
      print("wrong password");
      return false;
    }
    print("Login succeeded!");
    _isLoggedIn = true;
    _userId = userId;
    return true;

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
