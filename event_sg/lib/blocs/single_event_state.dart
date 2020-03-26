import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SingleEventState {
  const SingleEventState();
}
class SingleEventEmpty extends SingleEventState {}

class SingleEventLoading extends SingleEventState {}

class SingleEventLoaded extends SingleEventState {
  final Event event;
  const SingleEventLoaded({@required this.event}) : assert(event != null);
}

class SingleEventError extends SingleEventState {}

