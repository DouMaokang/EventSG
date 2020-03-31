import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EventListState {
  const EventListState();
}
class EventListEmpty extends EventListState {}

class EventListLoading extends EventListState {}

class EventListLoaded extends EventListState {
  final List<Event> upcomingEventList;
  final List<Event> recommendedEventList;
  final List<Event> allEvents;
  const EventListLoaded({@required this.upcomingEventList, @required this.recommendedEventList, @required this.allEvents});
}

class EventListError extends EventListState {}

