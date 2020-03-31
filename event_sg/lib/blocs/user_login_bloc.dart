import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:event_sg/globals/login.dart';
import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './blocs.dart';

import 'package:http/http.dart' as http;


class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {

//  final checkPasswordUrl = "${Urls.apiUrlBase}/user/login/$email/$password";
//  final passwordResponse = await http.get(checkPasswordUrl);

  @override
  UserLoginState get initialState => UserNotLoggedIn();

  @override
  Stream<UserLoginState> mapEventToState(
    UserLoginEvent event,
  ) async* {
    if (event is UserLoginClicked) {
      print(("${Urls.apiUrlBase}/user/login/${event.email}/${event.password}"));
      final response = await http.get("${Urls.apiUrlBase}/user/login/${event.email}/${event.password}");
      String userId = jsonDecode(response.body);
      print(userId);
      if (userId.length != Uuid().v4().length) {
        print("wrong password");
        yield UserNotLoggedIn();
      } else {
        print("Login succeeded!");
        Login().logIn(userId);
        yield UserLoginValidated();
      }
    }
  }
}
