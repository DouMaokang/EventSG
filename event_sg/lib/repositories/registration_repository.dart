
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:flutter/material.dart';

class RegistrationRepository {
  final RegistrationApiClient registrationApiClient;

  RegistrationRepository({@required this.registrationApiClient})
      : assert(registrationApiClient != null);

  bool registerEvent(String eventId, String userId) {
    return registrationApiClient.registerEvent(eventId, userId);
  }
  
  bool deregisterEvent(String eventId, String userId) {
    return registrationApiClient.deregisterEvent(eventId, userId);
  }

  Future<bool> hasRegistered(String eventId, String userId) {
    return registrationApiClient.hasRegistered(eventId, userId);
  }


}