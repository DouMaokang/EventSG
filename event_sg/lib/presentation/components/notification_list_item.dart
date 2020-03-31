import 'dart:async';

import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/presentation/sub_pages/event_details.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/repositories/notification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../sub_pages/event_feedback.dart';
import 'package:http/http.dart' as http;

class NotificationListItem extends StatefulWidget {
  NotificationDefined notification;
  NotificationListItem({Key key, @required this.notification}) :
        assert(notification != null),
        super(key: key);

  @override
  _NotificationListItemState createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {

//  final NotificationRepository notificationRepository = NotificationRepository(
//      notificationApiClient: NotificationApiClient(httpClient: http.Client())
//  );

  final EventRepository eventRepository = EventRepository(
      eventApiClient: EventApiClient(httpClient: http.Client())
  );

  Future myFutureEvent;

  @override
  void initState() {
    super.initState();
    // assign this variable your Future
    myFutureEvent = eventRepository.getEventById(widget.notification.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFutureEvent,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return new Container();
        Event event = snapshot.data;
        return new Card(
            color: Colors.white,
            child: ListTile(
              //leading: Image.asset(notification.image), // todo event image
                title: Text(
                  event.title,
                  style: _biggerFont,
                ),
                subtitle: Text(
                    _subtitleController(widget.notification.type)
                ),
                trailing: Row(
                    children:
                    <Widget>[Icon(Icons.arrow_forward_ios)],
                    mainAxisSize: MainAxisSize.min
                ),
                isThreeLine: true,
                onTap: () {
                  if (widget.notification.type == "review") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          EventFeedbackPage(eventId: event.eventId)),
                    );
                  } else if (widget.notification.type == 'venue' ||
                      widget.notification.type == 'registration' ||
                      widget.notification.type == 'deregistration' ||
                      widget.notification.type == 'event') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            BlocProvider<SingleEventBloc>(
                                create: (context) =>
                                    SingleEventBloc(
                                        eventRepository: eventRepository),
                                child: BlocBuilder<
                                    SingleEventBloc,
                                    SingleEventState>(
                                    builder: (context, state) {
                                      return EventDetailsPage(
                                          eventId: event.eventId);
                                    }
                                )
                            )
                        )
                    );
                  }
                }
            )
        );
      }
    );
  }


  String _subtitleController(String type) {
    if (type == "event") {
      return "The event organizer you liked is going to hold a new event!";
    } else if (type == "venue") {
      return "An event organizer would like to rent your venue. Please contact him.";
    } else if (type == "registration") {
      return "A user has registered this event.";
    } else if (type == "deregistration") {
      return "A user has deregistered this event.";
    } else if (type == "review") {
      return "A new review is provided for this event. Please check out.";
    }
  }

  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black);



}