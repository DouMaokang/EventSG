import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({@required this.userApiClient})
      : assert(userApiClient != null);

  Future<User> getUserById(String userId) async {
    return userApiClient.getUserById(userId);
  }

  Future<List<String>> getInterestedCategories(String userId) async {
    return userApiClient.getInterestedCategories(userId);
  }

}