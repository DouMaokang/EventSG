import 'package:flutter/material.dart';

import '../event_details.dart';

class EventListItem extends StatelessWidget {
  EventListItem({
    Key key,
    this.eventName,
    this.eventVenue,
    this.eventDate
  }) : super(key: key);

  final String eventName;
  final String eventVenue;
  final String eventDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventDetails()));
      },
//      child: Container(
//        height: 50.0,
//        padding: const EdgeInsets.all(8.0),
//        margin: const EdgeInsets.symmetric(horizontal: 8.0),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(5.0),
////          color: Colors.lightGreen[500],
//        ),
        child: new ListTile(
          leading: Image.asset('assets/event.png'),
          trailing:  Text(eventDate, style: TextStyle(color: Colors.black, fontSize: 18)),
          title: Text(eventName,style: TextStyle(color: Colors.black, fontSize: 18)),
          subtitle: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(Icons.location_on, size:18),
                  ),
                ),
                TextSpan(text: eventVenue, style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
          ),
        ),
      );
  }
}