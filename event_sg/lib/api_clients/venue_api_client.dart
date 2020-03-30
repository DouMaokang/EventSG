import 'dart:convert';

import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


// TODO: connect with the modified API
/// An network API client to fetch event data from app backend services.
class VenueApiClient {
  static const baseUrl = Urls.apiUrlBase;
  final http.Client httpClient;

  VenueApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  /// Returns all venues in a list fetched through a network request.
  Future<List<Venue>> getAllVenues() async {
    final eventUrl = '$baseUrl/venue';

    try {
      final eventResponse = await httpClient.get(eventUrl);
      List eventData = jsonDecode(eventResponse.body);
      print(eventData);
      List<Venue> venues = eventData.map((value) =>  Venue.fromJson(value)).toList();
      return venues;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  Future<List<Venue>> getVenueByOwnerId(String ownerId) async {
    final eventUrl = '$baseUrl/ownerId/$ownerId';
    try {
      final eventResponse = await httpClient.get(eventUrl);
      List eventData = jsonDecode(eventResponse.body);
      print(eventData);
      List<Venue> venues = eventData.map((value) =>  Venue.fromJson(value)).toList();
      return venues;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }

  Future<Venue> getVenueById(String venueId) async {
    final eventUrl = '$baseUrl/venueId/$venueId';

    try {
      final eventResponse = await httpClient.get(eventUrl);
      Map eventData = jsonDecode(eventResponse.body);
      print(eventData);
      Venue venue = Venue.fromJson(eventData);
      return venue;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('error getting event data!');
    }
  }


  Future<bool> postVenue(Venue venue) async {
    final url = '$baseUrl/venue';
    print('postVenue was called in api');

    try {
      final response = await httpClient.post(url,body: jsonEncode(venue.toJson()));
      bool data = jsonDecode(response.body);
      print(data);
      if (data) return true;
      else return false;
    } catch(e) {
      print('Caught error: $e');
      throw Exception('error posting venue!');
    }
  }

}

