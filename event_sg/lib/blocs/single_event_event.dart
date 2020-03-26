import 'package:meta/meta.dart';

@immutable
abstract class SingleEventEvent {
  const SingleEventEvent();
}

class SingleEventClicked extends SingleEventEvent {
  final String eventId;
  const SingleEventClicked({@required this.eventId}) : assert(eventId != null);
}
