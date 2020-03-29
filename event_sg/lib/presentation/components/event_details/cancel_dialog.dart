import 'package:event_sg/api_clients/registration_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/event_list_bloc.dart';
import 'package:event_sg/blocs/registration_bloc.dart';
import 'package:event_sg/repositories/registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class CancelDialog extends StatelessWidget {

  final RegistrationRepository registrationRepository = RegistrationRepository(
    // Add all required repositories here.
    registrationApiClient: RegistrationApiClient(httpClient: http.Client()),
  );


  String eventTitle, eventDateTime;
  String eventId, userId;
  final RegistrationBloc registrationBloc;


  CancelDialog({
    @required this.eventTitle,
    @required this.eventDateTime,
    @required this.eventId,
    @required this.userId,
    @required this.registrationBloc,
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
        'Confirm Deregistration',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: ListBody(
          children: <Widget>[
            Text('You\'re cancelling your registration for\n${this.eventTitle}'),
            Text('Event date & Time: ${this.eventDateTime}'),
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
            Navigator.of(context).pop();
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
            registrationBloc.add(
                CancelRegistration(eventId: eventId, userId: userId));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
