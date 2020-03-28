import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/api_clients/registration_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/registration_bloc.dart';
import 'package:event_sg/blocs/single_event_bloc.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/repositories/registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './registration_dialog.dart';
import 'package:http/http.dart' as http;


class EventRegistrationBar extends StatelessWidget {

    final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );


  String eventTitle;
  DateTime eventDateTime;
  String eventId, userId;
//  bool hasRegistered;


    EventRegistrationBar({
    Key key,
    @required this.eventTitle,
    @required this.eventDateTime,
    @required this.eventId,
    @required this.userId,
  })
      : super(key: key);


  final RegistrationRepository registrationRepository = RegistrationRepository(
    // Add all required repositories here.
    registrationApiClient: RegistrationApiClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    final RegistrationBloc registrationBloc = BlocProvider.of<RegistrationBloc>(context);
//
//    hasRegistered = registrationRepository.hasRegistered(eventId, userId) == "true";
//    print("herer" + registrationRepository.hasRegistered(eventId, userId).toString());
//    if (!hasRegistered) {
      return BottomAppBar(
        color: Colors.lightBlue,
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            if (state is RegistrationNotMade) {
              print("state: not made");

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                  ButtonBar(
                      children: [
                        FlatButton(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    RegistrationDialog(
                                      eventTitle: eventTitle,
                                      eventDateTime: eventDateTime
                                          .toString(),
                                      userId: userId,
                                      eventId: eventId,
                                      registrationBloc: registrationBloc,
                                    )
                            );
                          },
                          color: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                      ]
                  )
                ],
              );
            } else if (state is RegistrationConfirmed) {
              print("state: confirmed");

              return Text("Confirmed");
            } else if (state is RegistrationProcessing) {
              print("state: processing");

              return Text("Processing");
            } else {
              print("state: error");

              return Text("Error");
            }
          },
        ),
      );
//    } else {
//      return Text("Registered!");
//    }
  }

}



//
//
//Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//IconButton(
//icon: Icon(
//Icons.favorite_border,
//color: Colors.white,
//),
//),
//ButtonBar(
//children: [
//FlatButton(
//child: Text(
//"Register",
//style: TextStyle(
//color: Colors.white,
//),
//),
//onPressed: () {
//showDialog(
//context: context,
//builder: (BuildContext context) =>
//RegistrationDialog(
//eventName: "Alec's awsome event",
//eventDate: "24 Mar 2020",
//eventTime: "3:30 PM",));
//},
//color: Colors.purple,
//padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//),
//
//]
//)
//
//],
//),
