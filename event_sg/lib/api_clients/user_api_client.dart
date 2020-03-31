import 'dart:convert';

import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


// TODO: connect with the modified API
/// An network API client to fetch event data from app backend services.
class UserApiClient {
  // maokang's ip: 192.168.31.72
  // your local ip: 127.0.0.1
  static const baseUrl = 'http://192.168.31.72:8080/api';
  final http.Client httpClient;

  UserApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);


  Future<List<User>> getPersonalInfo() async {
    final eventUrl = '$baseUrl/event';

    try {
      final userResponse = await httpClient.get(eventUrl);
      List userData = jsonDecode(userResponse.body);
      print(userData);
      List<User> _userdata = userData.map((value) =>  User.fromJson(value)).toList();
      return _userdata;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting user data!');
    }
  }



}
