import 'dart:convert';

import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


// TODO: connect with the modified API
/// An network API client to fetch event data from app backend services.
class RegistrationApiClient {
  static const baseUrl = Urls.apiUrlBase;
  final http.Client httpClient;

  RegistrationApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

//  Future<List<Event>> getMyRegistrations(String userId) async {
//    final url = '$baseUrl/registration/userId/$userId';
//
//    try {
//      final response = await httpClient.get(url);
//      List data = jsonDecode(response.body);
//      print(data);
//      List<Event> events = data.map((value) =>  Event.fromJson(value)).toList();
//      return events;
//    } catch (e) {
//      print('Caught error: $e');
//      throw Exception('error getting event data!');
//    }
//
//  }


  bool registerEvent(String eventId, String userId) {
    final url = '$baseUrl/registration/add/$eventId/$userId';
    try {
      httpClient.post(url);
      return true;
    } catch (e) {
      print('Caught error: $e');
      return false;
    }
  }


  bool deregisterEvent(String eventId, String userId) {
    final url = '$baseUrl/registration/cancel/$eventId/$userId';
    try {
      httpClient.delete(url);
      return true;
    } catch (e) {
      print('Caught error: $e');
      return false;
    }
  }

  Future<bool> hasRegistered(String eventId, String userId) async {

    final url = '$baseUrl/registration/check/$eventId/$userId';

    try {
      final response = await httpClient.get(url);
      bool data = jsonDecode(response.body);
      if (data) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting data!');
    }
  }

}


