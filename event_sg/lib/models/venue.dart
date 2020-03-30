import 'package:flutter/foundation.dart';
import 'package:event_sg/models/models.dart';

class Venue {

  String venueId;
  String address;
  int postalCode;
  User ownerId;
  double rentalFee;
  double area;
  String description;
  String venueName;
  String image;

  Venue({this.venueId, this.address, this.postalCode, this.ownerId,
    this.rentalFee, this.area, this.description, this.venueName, this.image});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
        venueId: json['venueId'],
        address: json['address'],
        postalCode: json['postalCode'],
        ownerId: json['owner'],
        rentalFee: json['rentalFee'],
        area: json['area'],
        description: json['description'],
        venueName: json['venueName'],
      image: json['image'],
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