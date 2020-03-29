import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sg/models/models.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationEmpty extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationDefined> notifications;

  const NotificationLoaded({@required this.notifications}) : assert(notifications != null);

  @override
  List<Object> get props => [notifications];
}

class NotificationError extends NotificationState {}