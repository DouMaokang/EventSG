import 'dart:core';

import 'package:intl/intl.dart';


class Event {
  String eventId;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  DateTime registrationDeadline;
  int capacity;
  int numOfParticipants;
  double avgRating;

  // List<Review> reviewList;
  String category;
  String status;

  Event({
    this.eventId,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.registrationDeadline,
    this.capacity,
    this.numOfParticipants,
    this.avgRating,
    // TODO: parse reviewList (Maybe it should not be in the event class).
    // this.reviewList,
    this.category,
    this.status});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      eventId: json['eventId'],
      description: json['description'],
      startTime: DateFormat("dd-MM-yyyy HH:mm:ss").parse(json['startTime']),
      endTime: DateFormat("dd-MM-yyyy HH:mm:ss").parse(json['endTime']),
      registrationDeadline: DateFormat("dd-MM-yyyy HH:mm:ss").parse(
          json['registrationDeadline']),
      capacity: json['capacity'],
      numOfParticipants: json['numOfParticipants'],
      avgRating: json['avgRating'],
      // reviewList: json['reviewList'],
      category: json['category'],
      status: json['status'],
    );
  }
}