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


class EventListItem extends StatelessWidget {

  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  final Event event;

  EventListItem({ Key key, @required this.event })
      : assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SingleEventBloc, SingleEventState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<SingleEventBloc>(context).add(SingleEventClicked(eventId: event.eventId));
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    BlocProvider<SingleEventBloc>(
                        create: (context) => SingleEventBloc(eventRepository: eventRepository),
                        child: BlocBuilder<SingleEventBloc, SingleEventState>(
                            builder: (context, state) {
                              return EventDetailsPage(eventId: event.eventId);}
                        )
                    )
                )
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: 90,
                  decoration: BoxDecoration(
//
                    borderRadius: BorderRadius.circular(2.0),
                    image: DecorationImage(
                      // TODO: request an image through http calls
                      image: NetworkImage("https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                        child: Text(
                          DateFormat('dd/MM/yyyy hh:mm a').format(this.event.startTime).toString(),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal

                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        ),
                      ),
                      Container(
                        child: Text(
                          this.event.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.location_city, size: 14,),
                            SizedBox(width: 6,),
                            Text(
                              event.venue.venueName,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],),
                ),
              ],),
          ),
        );
      },

    );

  }


}