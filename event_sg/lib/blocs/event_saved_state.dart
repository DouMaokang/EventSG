import 'package:meta/meta.dart';

@immutable
abstract class EventSavedState {}

class EventNotSaved extends EventSavedState {}

class EventSaved extends EventSavedState {}
