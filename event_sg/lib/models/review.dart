class Review {
  String reviewId;
  String reviewerId;
  String eventId;
  double rating;
  String content;

  Review({
      this.reviewId, this.reviewerId, this.eventId, this.rating, this.content});

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
        reviewId: json['reviewId'],
        reviewerId: json['reviewerId'],
        eventId: json['eventId'],
        rating: json['rating'],
        content: json['rating']
    );
  }
}

