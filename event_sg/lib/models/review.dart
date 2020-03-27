import 'package:equatable/equatable.dart';

class Review extends Equatable{
  final String reviewId;
  final String reviewerId;
  final String eventId;
  final int rating;
  final String content;

  const Review({
    this.reviewId,
    this.reviewerId,
    this.eventId,
    this.rating,
    this.content
  });

  @override
  List<Object> get props => [
    reviewId,
    reviewerId,
    eventId,
    rating,
    content,
  ];

  static Review fromJson(dynamic json) {
    return Review(
      reviewId: json['reviewId'],
      reviewerId: json['reviewerId'],
      eventId: json['eventId'],
      rating: json['rating'] as int,
      content: json['content']
    );
  }

  Map toJson() => {
    'reviewId': reviewId,
    'reviewerId': reviewerId,
    'eventId': eventId,
    'rating': rating,
    'content': content
  };
}