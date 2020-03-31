import 'package:flutter/foundation.dart';
import 'package:event_sg/models/models.dart';

class Venue {

  String venueId;
  String address;
  int postalCode;
  User owner;
  String ownerId;
  double rentalFee;
  double area;
  String description;
  String venueName;
  String image;

  Venue({this.venueId, this.address, this.postalCode, this.owner,
    this.rentalFee, this.area, this.description, this.venueName, this.image});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
        venueId: json['venue']['venueId'],
        address: json['venue']['address'],
        postalCode: json['venue']['postalCode'],
        owner: User.fromJson(json['owner']),
        rentalFee: json['venue']['rentalFee'],
        area: json['venue']['area'],
        description: json['venue']['description'],
        venueName: json['venue']['venueName'],
      image: json['venue']['image'],
    );
  }

  Map<String,dynamic> toJson()=>{
    'venueId':venueId,
    'address':address,
    'postalCode':postalCode,
    'ownerId':ownerId,
    'rentalFee':rentalFee,
    'area':area,
    'description':description,
    'venueName':venueName,
  };
}