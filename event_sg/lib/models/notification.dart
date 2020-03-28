import 'package:equatable/equatable.dart';

class NotificationDefined extends Equatable {
  final String notificationId;
  final String eventId;
  final String type;
  final String reviewId;
  final int capacityLevel;
  final String time;

  const NotificationDefined({
    this.notificationId,
    this.eventId,
    this.type,
    this.reviewId,
    this.capacityLevel,
    this.time
  });

  @override
  List<Object> get props => [
    notificationId,
    eventId,
    type,
    reviewId,
    capacityLevel,
    time
  ];

  static NotificationDefined fromJson(dynamic json) {
    return NotificationDefined(
      notificationId: json['notificationId'],
      eventId: json['eventId'],
      type: json['type'],
      reviewId: json['reviewId'],
      capacityLevel: json['capacityLevel'] as int,
      time: json['time']
    );
  }
}