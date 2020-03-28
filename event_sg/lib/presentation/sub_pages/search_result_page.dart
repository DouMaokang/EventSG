import 'package:event_sg/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/search_bloc.dart';
import 'package:event_sg/blocs/search_state.dart';
import 'package:event_sg/models/event.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:http/http.dart' as http;


class SearchResultPage extends StatelessWidget {
  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Results"),
        ),
        body: BlocProvider<SearchBloc>(
            create: (contextC) => SearchBloc(eventRepository: eventRepository),
            child: SearchResultList()
        )
    );
  }
}

class SearchResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    BlocProvider<SearchBloc>(
//        create: (context) => SearchBloc(eventRepository: eventRepository));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Padding(
              padding: EdgeInsets.only(top: 16.0),
              child:Center(child: CircularProgressIndicator()));
        }
        if (state is SearchError) {
          return Text("error");
        }
        if (state is SearchLoaded) {
          return state.eventList.isEmpty
              ? Text("No applicable results")
              : Expanded(
            child: _SearchResults(
              eventList: state.eventList,
            ),
          );
        } else {
          return Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text("Empty")
          );
        }
      },
    );
  }
}


class _SearchResults extends StatelessWidget {
  final List<Event> eventList;

  const _SearchResults({Key key, @required this.eventList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (BuildContext context, int index) {
          return EventListItem(
            event: eventList[index],
          );
        });
  }
}
