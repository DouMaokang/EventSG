import 'dart:convert';

import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/models/notification.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class NotificationApiClient {

  static const baseUrl = '${Urls.apiUrlBase}/notification';

  final http.Client httpClient;

  NotificationApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<NotificationDefined>> getNotificationList(String userId) async {
    final notificationUrl = '$baseUrl/notification/$userId';
    try {
      final notificationResponse = await httpClient.get(notificationUrl);
      List notificationData = jsonDecode(notificationResponse.body);
      List<NotificationDefined> notifications = notificationData.map((value) =>  NotificationDefined.fromJson(value)).toList();
      return notifications;
    } catch(e) {
      print("caught error $e");
      throw Exception('error getting review data');
    }
  }
}