import 'package:flutter/material.dart';

class EventRegistration extends StatelessWidget {
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
          const ListTile(
            leading: Icon(Icons.timer),
            title: Text('Event Date & Time'),
            subtitle: Text('Sat, 7 Mar 2020 3:30 PM - 5:30 PM'),
          ),
          Divider(height: 0, indent: 16, endIndent: 16,),
          const ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Registration Deadline'),
            subtitle: Text('Sat, 7 Mar 2020 3:30 PM'),
          ),
          Divider(height: 0, indent: 16, endIndent: 16,),
          const ListTile(
            leading: Icon(Icons.event_seat),
            title: Text('Vacancy'),
            subtitle: Text('30 out of 50 vacancies are still available'),
          ),
        ],
      ),
    );

  }
}
