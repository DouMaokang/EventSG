import 'package:event_sg/api_clients/registration_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/registration_bloc.dart';
import 'package:event_sg/presentation/components/event_details/cancel_dialog.dart';
import 'package:event_sg/presentation/components/event_details/no_vacancy_dialog.dart';
import 'package:event_sg/repositories/registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './registration_dialog.dart';
import 'package:http/http.dart' as http;


class EventRegistrationBar extends StatefulWidget {

  final RegistrationRepository registrationRepository = RegistrationRepository(
    registrationApiClient: RegistrationApiClient(httpClient: http.Client()),
  );

  String eventTitle;
  DateTime eventDateTime;
  String eventId, userId;
  int vacancy;

  EventRegistrationBar({
    Key key,
    @required this.eventTitle,
    @required this.eventDateTime,
    @required this.eventId,
    @required this.userId,
    @required this.vacancy
  })
      : super(key: key);

  @override
  _EventRegistrationBarState createState() => _EventRegistrationBarState();
}

class _EventRegistrationBarState extends State<EventRegistrationBar> {

  bool _hasRegistered = false;


  @override
  void initState() {
    _checkHasRegistered(eventId: widget.eventId, userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final RegistrationBloc registrationBloc = BlocProvider.of<RegistrationBloc>(context);

    if (_hasRegistered) {
      registrationBloc.add(EnterWithRegistration());
    }

    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        if (state is RegistrationNotMade) {
          return FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Colors.blue,
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              if (widget.vacancy > 0) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        RegistrationDialog(
                          eventTitle: widget.eventTitle,
                          eventDateTime: widget.eventDateTime
                              .toString(),
                          userId: widget.userId,
                          eventId: widget.eventId,
                          registrationBloc: registrationBloc,
                        )
                );
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        NoVacancyDialog()
                );
              }
            },
          );
        } else if (state is RegistrationConfirmed) {
          return FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Colors.blue,
            child: Text(
              "Cancel Registration",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      CancelDialog(
                        eventTitle: widget.eventTitle,
                        eventDateTime: widget.eventDateTime
                            .toString(),
                        userId: widget.userId,
                        eventId: widget.eventId,
                        registrationBloc: registrationBloc,
                      )
              );
            },
          );

          return Text("Confirmed");
        } else if (state is RegistrationProcessing) {
          print("state: processing");

          return Text("Processing");
        } else {
          print("state: error");

          return Text("Error");
        }
      },
    );
  }

  _checkHasRegistered({String eventId, String userId}) async {
    bool result = await widget.registrationRepository.hasRegistered(eventId, userId);
    setState(() {
      _hasRegistered = result;
    });
  }
}