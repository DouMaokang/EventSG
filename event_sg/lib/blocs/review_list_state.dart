import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sg/models/models.dart';

abstract class ReviewListState extends Equatable {
  const ReviewListState();

  @override
  List<Object> get props => [];
}

class ReviewListEmpty extends ReviewListState {}

class ReviewListLoading extends ReviewListState {}

class ReviewListLoaded extends ReviewListState {
  final List<Review> reviews;
  const ReviewListLoaded({@required this.reviews}) : assert(reviews != null);
  @override
  List<Object> get props => [reviews];
}

class ReviewListError extends ReviewListState {}

