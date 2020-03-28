import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sg/models/models.dart';

abstract class AddReviewState extends Equatable {
  const AddReviewState();
  @override
  List<Object> get props => [];
}

class AddReviewAdded extends AddReviewState {}

class AddReviewAdding extends AddReviewState {
  final Review review;
  const AddReviewAdding({@required this.review}) : assert(review != null);
  @override
  List<Object> get props => [review];
  Review getReview() {return review;}
}

class AddReviewError extends AddReviewState {}

class AddReviewEmpty extends AddReviewState {}