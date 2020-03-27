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


class EventFeedbackPage extends StatelessWidget {

  final EventRepository eventRepository = EventRepository(
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  final ReviewRepository reviewRepository = ReviewRepository(
    reviewApiClient: ReviewApiClient(httpClient: http.Client()),
  );

  final Event event;
  EventFeedbackPage({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeedbackTopBar(), //todo feedbackTopBar
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SingleEventBloc>(
            create: (BuildContext context) => SingleEventBloc(eventRepository: eventRepository),
          ),
          BlocProvider<ReviewListBloc>(
            create: (BuildContext context) => ReviewListBloc(reviewRepository: reviewRepository),
          )
        ],
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                BlocBuilder<SingleEventBloc, SingleEventState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is SingleEventEmpty) {
                      BlocProvider.of<SingleEventBloc>(context).add(SingleEventClicked(eventId: event.eventId));
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SingleEventLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SingleEventError) {
                      return Text(
                        'Something went wrong!',
                        style: TextStyle(color: Colors.red),
                      );
                    } else if (state is SingleEventLoaded) {
                      return FeedbackHeader(
                        url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSy-W7gF6wc8shk2xxKWEt_JSLPiYG3G7c6kibQveo-RICfiCUp',
                        eventName: event.title,
                      );
                    }
                  },
                ),
                BlocBuilder<ReviewListBloc, ReviewListState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is ReviewListEmpty) {
                      BlocProvider.of<ReviewListBloc>(context).add(FetchReviewList(eventId: event.eventId));
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ReviewListLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ReviewListError) {
                      return Text(
                        'Something went wrong!',
                        style: TextStyle(color: Colors.red),
                      );
                    } else if (state is ReviewListLoaded) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 12,),
                          FeedbackSummary(
                            reviews: state.reviews
                          ),
                          FeedbackList(
                            reviews: state.reviews
                          )
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          )
        )
      )
    );
  }
}

