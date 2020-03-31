import 'package:event_sg/api_clients/registration_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/event_list_bloc.dart';
import 'package:event_sg/blocs/registration_bloc.dart';
import 'package:event_sg/repositories/registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';


class RegistrationDialog extends StatelessWidget {

  final RegistrationRepository registrationRepository = RegistrationRepository(
    // Add all required repositories here.
    registrationApiClient: RegistrationApiClient(httpClient: http.Client()),
  );


  String eventTitle;
  DateTime eventDateTime;
  String eventId, userId;
  final RegistrationBloc registrationBloc;


  RegistrationDialog({
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
              'Confirm Registration',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: ListBody(
                children: <Widget>[
                  Text('Event: ${this.eventTitle}'),
                  SizedBox(height: 8,),
                  Text('Event Time: ${DateFormat('dd/MM/yyyy hh:mm a').format(this.eventDateTime).toString()}'),
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
                  Toast.show("Registration Succeeded", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER, backgroundColor: Colors.blue);
                  registrationBloc.add(
                      ConfirmRegistration(eventId: eventId, userId: userId));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
  }
}
