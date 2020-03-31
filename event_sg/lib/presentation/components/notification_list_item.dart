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
import 'package:intl/intl.dart';
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
            return Center();
          Event event = snapshot.data;
          return SizedBox(
            height: 100,
            child: GestureDetector(
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
                },
              child: Card(

                  elevation: 0,
                  color: Colors.blue[50],
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                    child: Text(
                                      event.title,
                                      style: TextStyle(
                                          fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${DateFormat('dd/MM/yyyy').format(widget.notification.timeCreated)}",
                                    style: TextStyle(
                                        fontSize: 12,
                                      color: Colors.grey[600]
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          subtitle: Text(
                              _subtitleController(widget.notification.type),
                            style: TextStyle(fontSize: 15),
                          ),

                      ),

                    ],
                  )
              ),
            ),
          );
        }
    );
  }


  String _subtitleController(String type) {
    if (type == "event") {
      return "The event organizer you liked is going to hold a new event";
    } else if (type == "venue") {
      return "An event organizer would like to rent your venue";
    } else if (type == "registration") {
      return "A user has registered your event";
    } else if (type == "deregistration") {
      return "A user has cancelled his registration for you event";
    } else if (type == "review") {
      return "A new review is provided for your event";
    }
  }





}