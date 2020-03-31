import 'dart:core';

import 'package:event_sg/models/models.dart';
import 'package:intl/intl.dart';

class Event {
  String eventId;
  String title;
  String organizerId;
  String organizerName;
  String description;
  DateTime startTime;
  DateTime endTime;
  DateTime registrationDeadline;
  int capacity;
  int numOfParticipants;
  double avgRating;
  String category;
  String status;

  // Event has a ReviewList.
  List<Review> reviewList;

  // Event has a venue.
  Venue venue;

  // Event has an organizer.
  User organizer;

  // The image path of user profile picture.
  String image;

  Event({
    this.eventId,
    this.title,
    this.organizerId,
    this.organizerName,
    this.description,
    this.startTime,
    this.endTime,
    this.registrationDeadline,
    this.capacity,
    this.numOfParticipants,
    this.avgRating,
    this.category,
    this.status,
    this.reviewList,
    this.venue,
    this.organizer,
    this.image,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    var list = json['reviewList'] as List;
    List<Review> reviewList =
        list.map((review) => Review.fromJson(review)).toList();

    return Event(
      title: json['event']['title'],
      eventId: json['event']['eventId'],
      description: json['event']['description'],
      startTime:
          DateFormat("dd-MM-yyyy HH:mm:ss").parse(json['event']['startTime']),
      endTime:
          DateFormat("dd-MM-yyyy HH:mm:ss").parse(json['event']['endTime']),
      registrationDeadline: DateFormat("dd-MM-yyyy HH:mm:ss")
          .parse(json['event']['registrationDeadline']),
      capacity: json['event']['capacity'],
      numOfParticipants: json['event']['numOfParticipants'],
      avgRating: json['event']['avgRating'],
      category: json['event']['category'],
      status: json['event']['status'],
      reviewList: reviewList,
      venue: Venue.fromJson(json['venue']),
      organizer: User.fromJson(json['organizer']),
      image: json['event']['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'eventId': eventId,
        'organizerId': organizerId,
        'description': description,
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
        'registrationDeadline': registrationDeadline.toString(),
        'capacity': capacity,
        'category': category,
        'status': status,
        'venue': (venue == null) ? null : venue.toJson(),
      };
}
