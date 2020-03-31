import 'package:meta/meta.dart';

@immutable
abstract class EventListEvent {
  const EventListEvent();
}

class InitializeEventList extends EventListEvent {}
