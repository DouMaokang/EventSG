import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/event_saved_bloc.dart';
import 'package:event_sg/blocs/event_saved_state.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

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


  bool _hasSaved = false;

  @override
  void initState() {
    print("inside top bar: ${widget.eventId}");
    print("inside top bar: ${widget.userId}");

    _checkHasSaved(eventId: widget.eventId, userId: widget.userId);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    if (_hasSaved) {
      BlocProvider.of<EventSavedBloc>(context).add(EnterWithSave());
      print("_hasSaved: enter with save");
    }
    return AppBar(
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
        BlocBuilder<EventSavedBloc, EventSavedState>(
          // ignore: missing_return

            // ignore: missing_return
            builder: (context, state) {


              if (state is EventNotSaved) {
                return IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      BlocProvider.of<EventSavedBloc>(context).add(SaveEvent(eventId: widget.eventId, userId: widget.userId));
                    }
                );
              } else if (state is EventSaved) {
                return IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      BlocProvider.of<EventSavedBloc>(context).add(UnSaveEvent(eventId: widget.eventId, userId: widget.userId));
                    }
                );
              }
            }
        )
      ],
    );
  }

  _checkHasSaved({String eventId, String userId}) async {
    bool result = await eventRepository.checkHasLikedEvent(eventId: eventId, userId: userId);
    print("checkHasSaved result: ${result.toString()}");
    setState(() {
      _hasSaved = result;
    });
  }
}
