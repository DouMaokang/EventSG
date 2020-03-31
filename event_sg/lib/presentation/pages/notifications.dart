import 'dart:async';

import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/api_clients/event_api_client.dart';

import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/globals/login.dart';


import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/components/notification_list_item.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/repositories/notification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {

  String userId;


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

    myFutureList = notificationRepository.getNotificationList(Login().getUserId());


  }

  Widget _buildNotifications(List<NotificationDefined> notifications) {
    List<Widget> notificationList = new List<Widget>();
    for(var i = 0; i < notifications.length; i++){
      notificationList.add(NotificationListItem(notification: notifications[i]));
    }

    if (notificationList.length == 0) {
      return Center(
        heightFactor: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error_outline, size: 46,),
            SizedBox(height: 24,),
            Text(
              "You don't have any notifications",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),
            ),

          ],
        ),
      );
    } else {
      return Column(
          children: notificationList
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            title: Align (
                alignment: Alignment.center,
                child: const Text('Notifications')
            ),
          ),
        ),
          body: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: FutureBuilder(
                  future: myFutureList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return new Container();
                    List<NotificationDefined> notifications = snapshot.data;
                    return Container(
                      child: _buildNotifications(notifications),
                    );
                  }
              ),

            ),
          )
        );
  }
}