
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';
import 'package:flutter/material.dart';

class EventRepository {
  final EventApiClient eventApiClient;

  EventRepository({@required this.eventApiClient})
      : assert(eventApiClient != null);

  Future<List<Event>> getAllEvents() async {
    return eventApiClient.getAllEvents();
  }

  Future<Event> getEventById(String eventId) async {
    return eventApiClient.getEventById(eventId);
  }

  Future<List<Event>> getRegisteredEvents(String userId) async {
    return eventApiClient.getRegisteredEvent(userId);
  }

  Future<List<Event>> getRecommendedEvents(String userId) async {
    return eventApiClient.getRecommendedEvents(userId: userId);
  }

  Future<List<Event>> getUpcomingEvents(String userId) async {
    return eventApiClient.getUpcomingEvents(userId: userId);
  }

  Future<List<Event>> searchEventByTitle(String keyword) async {
    return eventApiClient.searchEventByTitle(keyword);
  }

  Future<bool> hasSavedEvent({@required String eventId, @required String userId}) {
    return eventApiClient.hasSaved(eventId, userId);
  }

  Future<List<Event>> getOrganizedEvents(String userId) async {
    return eventApiClient.getOrganizedEvents(userId: userId);
  }
  
  Future<bool> postEvent(Event event) async {
    return eventApiClient.postEvent(event);
  }

  Future<bool> saveDraftEvent(Event event) async {
    return eventApiClient.saveDraftEvent(event);
  }

}