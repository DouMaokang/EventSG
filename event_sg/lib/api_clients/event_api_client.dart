import 'dart:convert';

import 'package:event_sg/globals/login.dart';
import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/models/models.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


// TODO: connect with the modified API
/// An network API client to fetch event data from app backend services.
class EventApiClient {

  static const baseUrl = Urls.apiUrlBase;

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
      List<Event> events = eventData.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  Future<List<Event>> searchEventByTitle(String keyword) async {
    final eventUrl = '$baseUrl/event/search/$keyword';
    try{
      final response = await httpClient.get(eventUrl);
      List eventData = jsonDecode(response.body);
      List<Event> events = eventData.map((value) => Event.fromJson(value)).toList();
      return events;
    } catch(e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  Future<Event> getEventById(String eventId) async {
    final eventUrl = '$baseUrl/event/$eventId';

    try {
      final eventResponse = await httpClient.get(eventUrl);
      Map eventData = jsonDecode(eventResponse.body);
      final event = Event.fromJson(eventData);
      return event;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  /// Returns a list of recommended events based on a user's interests.
  Future<List<Event>> getRecommendedEvents({@required String userId}) async {
    final url = '$baseUrl/event/recommended/$userId';
    try {
      final response = await httpClient.get(url);
      List data = jsonDecode(response.body);
      List<Event> events = data.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  /// Returns a list of upcoming events (in 7 days) of a particular user.
  Future<List<Event>> getUpcomingEvents({@required String userId}) async {
    final url = '$baseUrl/event/upcoming/$userId/7';
    try {
      final response = await httpClient.get(url);
      List data = jsonDecode(response.body);
      List<Event> events = data.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  /// Returns a list of upcoming events (in 7 days) of a particular user.
  Future<List<Event>> getSavedEvents({@required String userId}) async {
    final url = '$baseUrl/event/all_saved_events/userId=$userId';
    try {
      final response = await httpClient.get(url);
      List data = jsonDecode(response.body);
      List<Event> events = data.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  /// Returns a list of events liked by a particular user.
  Future<List<Event>> getLikedEvents({@required String userId}) async {
    final url = '$baseUrl/event/all_saved_events/$userId';
    try {
      final response = await httpClient.get(url);
      List data = jsonDecode(response.body);
      List<Event> events = data.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  /// Returns a list of organized events by a user.
  Future<List<Event>> getOrganizedEvents({@required String userId}) async {
    final url = '$baseUrl/event/organizer/userId=$userId';
    try {
      final response = await httpClient.get(url);
      List data = jsonDecode(response.body);
      List<Event> events = data.map((value) =>  Event.fromJson(value)).toList();
      return events;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  void likeEvent({@required String eventId, @required String userId}) {
    final url = '$baseUrl/event/save_event/eventId=$eventId/userId=$userId';
    print(url);
    try {
      httpClient.post(url);
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error posting data!');
    }
  }

  void unlikeEvent({@required String eventId, @required String userId}) {
    final url = '$baseUrl/event/unsave_event/eventId=$eventId/userId=$userId';
    try {
      httpClient.delete(url);
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error posting data!');
    }
  }


  Future<bool> checkHasLikedEvent(String eventId, String userId) async {

    final url = '$baseUrl/event/has_saved/eventId=$eventId/userId=$userId';

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

  Future<bool> postEvent(Event event) async {
    HttpClient httpClient = new HttpClient();
    final url = '$baseUrl/event/add';
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    Map jsonMap = {
      "title": event.title,
      "description": event.description,
      "organizerId": Login().getUserId(),
      "startTime": DateFormat('dd-MM-yyyy hh:mm:ss').format(event.startTime).toString(),
      "endTime": DateFormat('dd-MM-yyyy hh:mm:ss').format(event.endTime).toString(),
      "registrationDeadline": DateFormat('dd-MM-yyyy hh:mm:ss').format(event.registrationDeadline).toString(),
      "numOfParticipants": 0,
      "avgRating": 0.0,
      "category": event.category,
      "capacity": event.capacity,
      "venueId": event.venue.venueId,
    };
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
  }

  Future<bool> saveDraftEvent(Event event) async {
    final url = '$baseUrl/event/add-draft';
    print('save was called in api');
    try {
      final response = await httpClient.post(url,body: jsonEncode(event.toJson()));
      bool data = jsonDecode(response.body);
      print(data);
      if (data) return true;
      else return false;
    } catch(e) {
      print('Caught error: $e');
      throw Exception('error saving event!');
    }
  }

}


