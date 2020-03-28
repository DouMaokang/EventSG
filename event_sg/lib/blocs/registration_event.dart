import 'package:meta/meta.dart';

@immutable
abstract class RegistrationEvent {
  const RegistrationEvent();
}

class ConfirmRegistration extends RegistrationEvent {
  final String eventId;
  final String userId;
  const ConfirmRegistration({@required this.eventId, @required this.userId})
      : assert(eventId != null, userId != null);
}

class CancelRegistration extends RegistrationEvent {
  final String eventId;
  final String userId;
  const CancelRegistration({@required this.eventId, @required this.userId})
      : assert(eventId != null, userId != null);
}
