import 'package:flutter/material.dart';

class EventRegistration extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final DateTime registrationDeadline;
  final int capacity;
  final int numOfParticipants;

  EventRegistration({Key key,
    @required this.startTime,
    @required this.endTime,
    @required this.registrationDeadline,
    @required this.capacity,
    @required this.numOfParticipants
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              child: Text(
                "Registration",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

              ),
              alignment: Alignment.topLeft,
            ),
          ),
          SizedBox(height: 4,),
          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Event Date & Time'),
            subtitle: Text("${this.startTime.toString()} - ${this.endTime.toString()}"),
          ),
          Divider(height: 0, indent: 16, endIndent: 16,),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Registration Deadline'),
            subtitle: Text(this.registrationDeadline.toString()),
          ),
          Divider(height: 0, indent: 16, endIndent: 16,),
          ListTile(
            leading: Icon(Icons.event_seat),
            title: Text('Vacancy'),
            subtitle: Text('${this.capacity - this.numOfParticipants} out of ${this.capacity.toString()} vacancies are still available'),
          ),
        ],
      ),
    );

  }
}
