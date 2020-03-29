import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/blocs/blocs.dart';

class ReviewListBloc extends Bloc<ReviewListEvent, ReviewListState> {
  final ReviewRepository reviewRepository;
  
  ReviewListBloc({@required this.reviewRepository}) : assert(reviewRepository != null);
  
  @override
  ReviewListState get initialState => ReviewListEmpty();
  
  @override
  Stream<ReviewListState> mapEventToState(ReviewListEvent event) async* {
    if (event is FetchReviewList) {
      yield ReviewListLoading();
      try {
        final List<Review> reviews = await reviewRepository.getReviewsByEventId(event.eventId);
        yield ReviewListLoaded(reviews: reviews);
      } catch (_) {
        yield ReviewListError();
      }
    }
  }
}