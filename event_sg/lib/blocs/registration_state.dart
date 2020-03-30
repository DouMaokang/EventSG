import 'package:meta/meta.dart';

@immutable
abstract class RegistrationState {
  const RegistrationState();
}

class RegistrationNotMade extends RegistrationState {}

class RegistrationConfirmed extends RegistrationState {
  final hasRegistered;
  const RegistrationConfirmed({@required this.hasRegistered})
      : assert(hasRegistered != null);
}

class RegistrationProcessing extends RegistrationState {}

class RegistrationError extends RegistrationState {}

class CancellationProcessing extends RegistrationState {}

