import 'package:flutter/material.dart';


class OrganizerAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
      ),
      title: Text(
        'My awsome event organizer name',
        style: TextStyle(
            fontSize: 16),
      ),
    );
  }
}
