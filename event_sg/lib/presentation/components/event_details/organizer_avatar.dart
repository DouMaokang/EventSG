import 'package:event_sg/models/models.dart';
import 'package:flutter/material.dart';


class OrganizerAvatar extends StatelessWidget {

  final User organizer;

  OrganizerAvatar({Key key, @required this.organizer})
    : assert(organizer != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
      ),
      title: Text(
        this.organizer.userName,
        style: TextStyle(
            fontSize: 16),
      ),
    );
  }
}
