import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:convert';
import 'package:event_sg/models/models.dart';

class NotificationApiClient {
  static const baseUrl = 'http://127.0.0.1:8080/api/notification';
  final http.Client httpClient;

  NotificationApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  Future<List<NotificationDefined>> getNotificationList(String userId) async {
    final notificationUrl = '$baseUrl/$userId';
    try {
      final notificationResponse = await this.httpClient.get(notificationUrl);
      List notificationData = jsonDecode(notificationResponse.body);
      print(notificationData);
      List<NotificationDefined> notifications = notificationData.map((value) =>  NotificationDefined.fromJson(value)).toList();
      return notifications;
    } catch(e) {
      print("caught error $e");
      throw Exception('error getting notification data');
    }
  }
}