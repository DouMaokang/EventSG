import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/components/event_feedback/feedback_widgets.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/models/models.dart';


class EventFeedbackPage extends StatefulWidget {
  String eventId;
  EventFeedbackPage({Key key, @required this.eventId}) : assert(eventId != null), super(key: key);


  @override
  _EventFeedbackPageState createState() => _EventFeedbackPageState();
}

class _EventFeedbackPageState extends State<EventFeedbackPage> {
  final EventRepository eventRepository = EventRepository(
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  final ReviewRepository reviewRepository = ReviewRepository(
    reviewApiClient: ReviewApiClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(44.0),
            child: BlocProvider<EventSavedBloc>(
              create: (context) => EventSavedBloc(eventRepository: eventRepository),
              child: FeedbackTopBar(),
            )
        ),
        body: new FutureBuilder(
          future: eventRepository.getEventById(widget.eventId),
          builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
            if (!snapshot.hasData)
              return new Container();
            Event event = snapshot.data;
            return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      FeedbackHeader(
                        event: event,
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 12,),
                          FeedbackSummary(
                              reviews: event.reviewList
                          ),
                          FeedbackList(
                              reviews: event.reviewList
                          )
                        ],
                      )
                    ],
                  ),
                )
            );
          }
        ),
      );
  }
}

