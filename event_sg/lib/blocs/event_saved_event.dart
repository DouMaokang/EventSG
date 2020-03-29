import 'package:meta/meta.dart';

@immutable
abstract class EventSavedEvent {
  const EventSavedEvent();
}

class SaveEvent extends EventSavedEvent {
  final String eventId;
  final String userId;
  const SaveEvent({@required this.eventId, @required this.userId})
      : assert(eventId != null, userId != null);
}


class UnSaveEvent extends EventSavedEvent {
  final String eventId;
  final String userId;
  const UnSaveEvent({@required this.eventId, @required this.userId})
      : assert(eventId != null, userId != null);
}

class EnterWithSave extends EventSavedEvent {}