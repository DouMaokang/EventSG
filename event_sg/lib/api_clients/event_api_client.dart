import 'dart:convert';

import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


// TODO: connect with the modified API
/// An network API client to fetch event data from app backend services.
class EventApiClient {
  static const baseUrl = 'http://192.168.31.72:8080/api';
  final http.Client httpClient;

  EventApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  /// Returns all events in a list fetched through a network request.
  Future<List<Event>> getAllEvents() async {
    final eventUrl = '$baseUrl/event';

    try {
      final eventResponse = await httpClient.get(eventUrl);
      List eventData = jsonDecode(eventResponse.body);
      print(eventData);
      List<Event> events = eventData.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  Future<List<Event>> getRegisteredEvent(String userId) async {
    final eventUrl = '$baseUrl/event/registered/$userId';
    try {
      final eventResponse = await httpClient.get(eventUrl);
      List eventData = jsonDecode(eventResponse.body);
      print(eventData);
      List<Event> events = eventData.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  Future<Event> getEventById(String eventId) async {
    final eventUrl = '$baseUrl/event/$eventId';

    try {
      final eventResponse = await httpClient.get(eventUrl);
      Map eventData = jsonDecode(eventResponse.body);
      print(eventData);
      final event = Event.fromJson(eventData);
      return event;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  /// Returns a list of recommended events based on a user's interests.
  Future<List<Event>> getRecommendedEvents() async {
    return null;
  }

  /// Returns a list of popular events based on the number of saves/likes.
  Future<List<Event>> getPopularEvents() async {
    return null;
  }

}


