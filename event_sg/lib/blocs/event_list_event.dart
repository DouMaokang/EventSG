import 'package:meta/meta.dart';

@immutable
abstract class EventListEvent {
  const EventListEvent();
}

class GetAllEvents extends EventListEvent {}

class GetCreatedEvents extends EventListEvent {}
//class GetEventByOrganizer extends EventListEvent{}
