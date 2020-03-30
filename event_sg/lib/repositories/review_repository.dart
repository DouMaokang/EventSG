import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';
import 'package:flutter/material.dart';

class ReviewRepository {
  final ReviewApiClient reviewApiClient;

  ReviewRepository({@required this.reviewApiClient}) : assert(reviewApiClient != null);

  Future<int> addReview(Review review) async {
    return reviewApiClient.addReview(review);
  }

  Future<Review> getReviewById(String reviewId) async {
    return reviewApiClient.getReviewById(reviewId);
  }

  Future<List<Review>> getReviewsByEventId(String eventId) async {
    return reviewApiClient.getReviewsByEventId(eventId);
  }

  Future<bool> hasReviewed({@required String eventId, @required String userId}) {
    return reviewApiClient.hasReviewed(eventId, userId);
  }
}