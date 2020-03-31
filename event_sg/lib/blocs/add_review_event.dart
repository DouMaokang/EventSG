import 'package:meta/meta.dart';
import 'package:event_sg/models/models.dart';
@immutable
abstract class AddReviewEvent {
  const AddReviewEvent();
}

class AddReview extends AddReviewEvent {}

class EnterWithAdded extends AddReviewEvent {}
//class UnSaveEvent extends EventSavedEvent {
//  final String eventId;
//  final String userId;
//  const UnSaveEvent({@required this.eventId, @required this.userId})
//      : assert(eventId != null, userId != null);
//}

