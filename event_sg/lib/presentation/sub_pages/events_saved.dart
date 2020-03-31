
/*
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/sub_pages/event_details.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../models/event.dart';
import '../../models/event.dart';
import '../../models/event.dart';



/// This is the stateful widget that the main application instantiates.
class EventsSaved extends StatefulWidget {
  final Event event;



  EventsSaved({ Key key, @required this.event })
      : assert(event != null),
        super(key: key);

  @override
  _EventsSavedState createState() => _EventsSavedState();
}


class _EventsSavedState extends State<EventsSaved> {
  Event event;
  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[


          ]
      ),
      body: new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[


          new RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: "Events Saved",
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32)),
                  ]
              )
          ),
          SizedBox(height: 16,),
          BlocBuilder<EventListBloc, EventListState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EventListEmpty) {
                BlocProvider.of<EventListBloc>(context)
                   // .add(GetSavedEvents(userId));
                return Text("Empty");
              } else if (state is EventListLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EventListLoaded) {
                return BlocProvider<SingleEventBloc>(
                  create: (context) => SingleEventBloc(eventRepository: eventRepository),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return new EventListItem(event: state.eventList[index], key: UniqueKey(),);
                    },
                    itemCount: state.eventList.length,
                  ),
                );
              }

            },
          ),
          SizedBox(height: 24,),
        ],
      ),
      backgroundColor: Colors.white,
    );



  }




}
*/