

import 'dart:async';

import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../sub_pages/event_feedback.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  User user;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // ignore: missing_return
      onRefresh: () {
        BlocProvider.of<NotificationBloc>(context).add(
          Refresh(userId: user.userId)
        );
        return _refreshCompleter.future;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        // body: _buildSuggestions(),
        body: Center(
          child: BlocConsumer<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is NotificationLoaded) {
                _refreshCompleter ?.complete();
                _refreshCompleter = Completer();
              }
            },
            // ignore: missing_return
            builder: (context, state) {
              if (state is NotificationLoaded) {
                return ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final Event event = _getEventById(state.notifications[index].eventId) as Event;
                    return Card(
                        color: Colors.white,
                        child: ListTile(
                          //leading: Image.asset(notification.image), // todo event image
                          title: Text(
                            event.title,
                            style: _biggerFont,
                          ),
                          subtitle: Text(
                              state.notifications[index].type
                          ),
                          trailing: Row(
                              children:
                              <Widget>[Icon(Icons.arrow_forward_ios)],
                              mainAxisSize: MainAxisSize.min
                          ),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EventFeedbackPage(event: event)),
                            );
                          },
                        )
                    );
                  },
                );
              } else if (state is NotificationError){
                return Text("GetNotificationList() error");
              } else if (state is NotificationLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NotificationEmpty) {
                BlocProvider.of<NotificationBloc>(context).add(GetNotificationList(userId: user.userId));
              }
            },
          ),
        ),
        backgroundColor: Colors.white,
      )
    );
  }

  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black);

  Future<Event> _getEventById(String eventId) async {
    return await eventRepository.getEventById(eventId);
  }
}