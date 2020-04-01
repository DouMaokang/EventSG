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
        radius: 20,
        backgroundImage: AssetImage(organizer.image),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.organizer.userName,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      subtitle: Text(
        this.organizer.email,
        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16,),
      ),
    );
  }
}
