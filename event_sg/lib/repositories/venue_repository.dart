
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';
import 'package:flutter/material.dart';

class VenueRepository {
  final VenueApiClient venueApiClient;

  VenueRepository({@required this.venueApiClient})
      : assert(venueApiClient != null);

  Future<List<Venue>> getAllVenues() async {
    return venueApiClient.getAllVenues();
  }

  Future<Venue> getVenueById(String venueId) async {
    return venueApiClient.getVenueById(venueId);
  }

  Future<List<Venue>> getVenueByOwnerId(String ownerId) async {
    return venueApiClient.getVenueByOwnerId(ownerId);
  }

  Future<bool> postVenue(Venue venue) async {
    return venueApiClient.postVenue(venue);
  }


}
