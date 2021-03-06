import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/event_saved_bloc.dart';
import 'package:event_sg/blocs/event_saved_state.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/presentation/sub_pages/add_review.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:event_sg/globals/login.dart';

class EventTopBar extends StatefulWidget {

  final eventId;
  final userId;

  EventTopBar({@required this.eventId, @required this.userId});


  @override
  _EventTopBarState createState() => _EventTopBarState();
}

class _EventTopBarState extends State<EventTopBar> {



  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  final ReviewRepository reviewRepository = ReviewRepository(
    reviewApiClient: ReviewApiClient(httpClient: http.Client())
  );


  bool _hasSaved = false;
  bool _hasReviewed = false;

  @override
  void initState() {
    super.initState();
    _checkHasSaved(eventId: widget.eventId, userId: widget.userId);
    _checkHasReviewed(eventId: widget.eventId, userId: widget.userId);
  }


  @override
  Widget build(BuildContext context) {

    //_checkHasReviewed(eventId: widget.eventId, userId: Login().getUserId());
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to previous page',
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Align (
            alignment: Alignment.centerLeft,
            child: const Text('Event Details')
        ),
        actions: <Widget>[
          // -------------------------- add review button with bloc ---------------------
          BlocProvider<AddReviewBloc>(
            create: (context) => AddReviewBloc(reviewRepository: reviewRepository),

            child: BlocBuilder<AddReviewBloc, AddReviewState>(
              // ignore: missing_return
                builder: (context, state) {

                  if (_hasReviewed) {
                    BlocProvider.of<AddReviewBloc>(context).add(EnterWithAdded());
                  }

                  if (state is AddReviewAdded) {
                    return IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {
                          Toast.show("You have added a review", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP); // remove if you want
                        }
                    );
                  } else {
                    return IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>ReviewAddingPage(eventId: widget.eventId)),
                          );
                        }
                    );
                  }
                }
            ),
          ),

          // -------------------------- save event button- ---------------------
          BlocProvider<EventSavedBloc>(
            create: (context) => EventSavedBloc(eventRepository: eventRepository),

            child: BlocBuilder<EventSavedBloc, EventSavedState>(
              // ignore: missing_return
                builder: (context, state) {

                  if (_hasSaved) {
                    BlocProvider.of<EventSavedBloc>(context).add(EnterWithSave());
                  }

                  if (state is EventSaved) {
                    return IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.redAccent,),
                        onPressed: () {
                          Toast.show("Event Unsaved", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP); // remove if you want
                          BlocProvider.of<EventSavedBloc>(context).add(UnSaveEvent(eventId: widget.eventId, userId: widget.userId));
                        }
                    );
                  } else {
                    return IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          Toast.show("Event Saved", context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
                          BlocProvider.of<EventSavedBloc>(context).add(SaveEvent(eventId: widget.eventId, userId: widget.userId));
                        }
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }

  _checkHasSaved({String eventId, String userId}) async {
    bool result = await eventRepository.checkHasLikedEvent(eventId: eventId, userId: userId);
    setState(() {
      _hasSaved = result;
    });
  }

  _checkHasReviewed({String eventId, String userId}) async {
    print(reviewRepository.hasReviewed(eventId: eventId, userId: userId));
    bool result = await reviewRepository.hasReviewed(eventId: eventId, userId: userId);
    print("eventId: $eventId userId: $userId");
    print("checkHasReviewed result: ${result.toString()}");
    setState(() {
      _hasReviewed = result;
    });
  }
}
