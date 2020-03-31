import 'package:event_sg/api_clients/registration_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/event_list_bloc.dart';
import 'package:event_sg/blocs/registration_bloc.dart';
import 'package:event_sg/models/event.dart';
import 'package:event_sg/repositories/registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

/*

class PostEventDialog extends StatelessWidget {

  final Event event;


  PostEventDialog({
    @required this.event,
  });


 */
bool postEventDialog(BuildContext context,Event event) {
    showDialog(context: context,
    builder:(BuildContext context)
    {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 2,
        backgroundColor: Colors.white,

        title: Text(
          'Confirm Event Posting',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: ListBody(
            children: <Widget>[
              Text('Event Name: ${event.title}\n@${event.venue.venueName}'),
              SizedBox(height: 8,),
              Text('Start Time: ${DateFormat('dd/MM/yyyy').format(event.startTime).toString()}'),
              Text('End Time: ${DateFormat('dd/MM/yyyy').format(event.endTime).toString()}'),
            ],
          ),
        ),
        actions: [
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(context);
              return false;
            },
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Confirm',
              style: TextStyle(fontWeight: FontWeight.bold),),
            color: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              return true;
            },
          ),
        ]
      );
    },
    );
}
