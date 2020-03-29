import 'package:event_sg/models/models.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:event_sg/blocs/blocs.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  final ReviewRepository reviewRepository;

  AddReviewBloc({@required this.reviewRepository}) : assert(reviewRepository != null);

  @override
  AddReviewState get initialState => AddReviewEmpty();

  @override
  Stream<AddReviewState> mapEventToState(AddReviewEvent event) async* {
    if (event is ConfirmReview) {
      try {
        final Review review = event.review;
        reviewRepository.addReview(review);
        yield AddReviewAdded();
      } catch(_) {
        yield AddReviewError();
      }
    }
  }
}