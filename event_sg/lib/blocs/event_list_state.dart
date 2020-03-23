import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EventListState {
  const EventListState();
}
class EventListEmpty extends EventListState {}

class EventListLoading extends EventListState {}

class EventListLoaded extends EventListState {
  final List<Event> eventList;
  const EventListLoaded({@required this.eventList}) : assert(eventList != null);
}

class EventListError extends EventListState {}

