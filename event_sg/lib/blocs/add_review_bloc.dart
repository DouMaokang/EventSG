import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/repositories/review_repository.dart';
import 'package:flutter/cupertino.dart';
import './blocs.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  ReviewRepository reviewRepository;

  AddReviewBloc({@required this.reviewRepository});

  @override
  AddReviewState get initialState => AddReviewNotAdded();

  @override
  Stream<AddReviewState> mapEventToState(
      AddReviewEvent event,
      ) async* {
    if (event is AddReview) {
      yield AddReviewAdded();
    } else if (event is EnterWithAdded) {
      yield AddReviewAdded();
    }
  }
}
