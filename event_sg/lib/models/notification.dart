import 'dart:core';

import 'package:event_sg/models/models.dart';
import 'package:intl/intl.dart';


class NotificationDefined {
  String notificationId;
  String type;
  DateTime timeCreated;
  String eventId;
  String userId;

  NotificationDefined({
    this.notificationId,
    this.type,
    this.timeCreated,
    this.eventId,
    this.userId
  });


  factory NotificationDefined.fromJson(Map<String, dynamic> json) {
    return NotificationDefined(
      notificationId: json['notificationId'],
      type: json['type'],
      timeCreated: DateFormat("dd-MM-yyyy HH:mm:ss").parse(json['timeCreated']),
      eventId: json['eventId'],
      userId: json['userId']
    );
  }
}