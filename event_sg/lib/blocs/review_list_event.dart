import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewListEvent extends Equatable {
  const ReviewListEvent();
}

class FetchReviewList extends ReviewListEvent {
  final String eventId;

  const FetchReviewList({@required this.eventId}) : assert(eventId != null);

  @override
  List<Object> get props => [eventId];
}