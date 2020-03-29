import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddReviewEvent extends Equatable {
  const AddReviewEvent();
}

@immutable
class ConfirmReview extends AddReviewEvent {
  final Review review;

  const ConfirmReview({@required this.review})
      : assert(review != null);

  @override
  List<Object> get props => [review];
}
