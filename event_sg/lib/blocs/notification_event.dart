import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class GetNotificationList extends NotificationEvent {
  final String userId;

  const GetNotificationList({@required this.userId}) : assert(userId != null);

  @override
  List<Object> get props => [userId];
}