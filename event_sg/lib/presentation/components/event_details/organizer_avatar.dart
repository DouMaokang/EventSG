import 'package:flutter/material.dart';


class OrganizerAvatar extends StatelessWidget {

  final String organizerName;
  // TODO: add organizer avatar.
  // final Image image;

  OrganizerAvatar({Key key, @required this.organizerName})
    : assert(organizerName != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
      ),
      title: Text(
        this.organizerName,
        style: TextStyle(
            fontSize: 16),
      ),
    );
  }
}
