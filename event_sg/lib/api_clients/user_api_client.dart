import 'dart:convert';

import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/globals/urls.dart';


// TODO: connect with the modified API
/// An network API client to fetch event data from app backend services.
class UserApiClient {
  // maokang's ip: 192.168.31.72
  // your local ip: 127.0.0.1
  static const baseUrl = Urls.apiUrlBase;
  final http.Client httpClient;

  UserApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);


  Future<User> getUserById(String userId) async {
    final userUrl = '$baseUrl/user/$userId';

    try {
      final userResponse = await httpClient.get(userUrl);
      Map userData = jsonDecode(userResponse.body);
      final user = User.fromJson(userData);
      return user;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting user data!');
    }
  }

  Future<List<String>> getInterestedCategories(String userId) async {
    final userUrl = '$baseUrl/user/getCategories/$userId';
    try {
      final userResponse = await httpClient.get(userUrl);
      List data = jsonDecode(userResponse.body);
      final categories = List<String>();
      for (var i = 0; i < data.length; i++){
        categories.add(data[i]);
      }
      return categories;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting user data!');
    }

  }

}