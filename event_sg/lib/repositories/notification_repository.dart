import 'dart:async';
import 'package:meta/meta.dart';
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';

class NotificationRepository {
  final NotificationApiClient notificationApiClient;

  NotificationRepository({@required this.notificationApiClient}) : assert(notificationApiClient != null);

  Future<List<NotificationDefined>> getNotificationList(String userId) async {
    return notificationApiClient.getNotificationList(userId);
  }
}