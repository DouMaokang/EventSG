import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/presentation/sub_pages/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/models/event.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:http/http.dart' as http;


class SearchResultPage extends StatelessWidget {
  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );
  final List<Event> eventList;

  SearchResultPage({@required this.eventList});

  @override
  Widget build(BuildContext context) {
    if (eventList == null || eventList.length == 0){
      return Scaffold(
          appBar: AppBar(
            title: Text("Search Results"),
          ),
          body: Center(child: Text("No results"))
      );
    } else{
      return BlocProvider<SingleEventBloc>(
          create: (context) => SingleEventBloc(eventRepository: eventRepository),
          child: Scaffold(
              appBar: AppBar(
                title: Text("Search Results"),
              ),
              body: ListView.builder(
                  itemCount: eventList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EventListItem(
                      event: eventList[index],
                    );
                  })
        ));
      }
    }
}
