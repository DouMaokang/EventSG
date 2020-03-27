class Registration {

  String userId;
  String eventId;

  Registration({this.userId, this.eventId});

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
        userId: json['userId'],
        eventId: json['eventId']
    );
  }
}