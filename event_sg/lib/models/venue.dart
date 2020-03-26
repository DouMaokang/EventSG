import 'package:flutter/foundation.dart';

class Venue {

  String venueId;
  String address;
  int postalCode;
  String ownerId;
  double rentalFee;
  double area;
  String description;
  String venueName;

  Venue({this.venueId, this.address, this.postalCode, this.ownerId,
    this.rentalFee, this.area, this.description, this.venueName});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
        venueId: json['venueId'],
        address: json['address'],
        postalCode: json['postalCode'],
        ownerId: json['ownerId'],
        rentalFee: json['rentalFee'],
        area: json['area'],
        description: json['description'],
        venueName: json['venueName']
    );
  }
}