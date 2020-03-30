import 'package:event_sg/models/models.dart';

class Review {
  String reviewId;
  String reviewerId;
  String eventId; // there is already a review list in event!
  double rating;
  String content;

  Review({
      this.reviewId, this.reviewerId, this.eventId, this.rating, this.content});

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
        reviewId: json['reviewId'],
        reviewerId: json['reviewer'],
        eventId: json['eventId'],
        rating: json['rating'],
        content: json['content']
    );
  }
}

