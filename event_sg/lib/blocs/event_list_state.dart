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
  final List<Event> createdEventList;
  final List<Event> registeredEventList;
  final List<Event> savedEventList;
  const EventListLoaded({@required this.upcomingEventList, @required this.recommendedEventList, @required this.allEvents, @required this.registeredEventList, @required this.createdEventList, @required this.savedEventList});
}

class EventListError extends EventListState {}

