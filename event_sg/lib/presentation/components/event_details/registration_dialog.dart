import 'package:flutter/material.dart';

class RegistrationDialog extends StatelessWidget {

  String eventName, eventDate, eventTime;

  RegistrationDialog({
    @required this.eventName,
    @required this.eventDate,
    @required this.eventTime,
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 2,
      backgroundColor: Colors.white,

      title: Text(
          'Confirm Your Registration',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: ListBody(
          children: <Widget>[
            Text('You\'re registering for ${this.eventName}'),
            Text('Event date & Time: ${this.eventDate} ${this.eventTime}'),
          ],
        ),
      ),
      actions: [
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Cancel',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Confirm',
            style: TextStyle(fontWeight: FontWeight.bold),),
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
