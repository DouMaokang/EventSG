import 'package:event_sg/components/event_details/event_description.dart';
import 'package:event_sg/components/event_details/event_footer.dart';
import 'package:event_sg/components/event_details/event_header.dart';
import 'package:event_sg/components/event_details/event_location.dart';
import 'package:event_sg/components/event_details/event_reg_bar.dart';
import 'package:event_sg/components/event_details/event_registration.dart';
import 'package:event_sg/components/event_details/event_top_bar.dart';
import 'package:flutter/material.dart';
import 'components/event_details/event_header.dart';
import 'components/event_details/organizer_avatar.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateful widget that the main application instantiates.
class EventDetailsPage extends StatefulWidget {

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}


class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventTopBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              EventHeader(
                url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSy-W7gF6wc8shk2xxKWEt_JSLPiYG3G7c6kibQveo-RICfiCUp',
                eventName: "My Awsome & Beautiful Event Name",),
              SizedBox(height: 16,),
              OrganizerAvatar(),
              EventRegistration(),
              SizedBox(height: 16,),
              EventDescription(),
              SizedBox(height: 24,),
              EventLocation(),
              EventFooter(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: EventRegistrationBar(),
    );
  }
}
