import 'dart:async';

import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/presentation/components/notification_list_item.dart';
import 'package:event_sg/presentation/sub_pages/event_details.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/repositories/notification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../sub_pages/event_feedback.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  String userId;
  Notifications({Key key, @required this.userId}) :
        assert(userId != null),
        super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final NotificationRepository notificationRepository = NotificationRepository(
    notificationApiClient: NotificationApiClient(httpClient: http.Client())
  );

  final EventRepository eventRepository = EventRepository(
    eventApiClient: EventApiClient(httpClient: http.Client())
  );

  Future myFutureList;
  Future myFutureEvent;

  @override
  void initState() {
    super.initState();
    // assign this variable your Future
    myFutureList = notificationRepository.getNotificationList(widget.userId);
  }

  Widget _buildNotifications(List<NotificationDefined> notifications) {
    List<Widget> notificationList = new List<Widget>();
    for(var i = 0; i < notifications.length; i++){
      notificationList.add(NotificationListItem(notification: notifications[i]));
    }
    return Container(
      child: Column(
          children: notificationList
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Notifications'),
          ),
          // body: _buildSuggestions(),
          body: SingleChildScrollView(
            child: Center(
                child: FutureBuilder(
                    future: myFutureList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return new Container();
                      List<NotificationDefined> notifications = snapshot.data;
                      print(notifications);
                      return Container(
                        child: _buildNotifications(notifications),
                      );
                    }
                )
            ),
          )
        );
  }
}