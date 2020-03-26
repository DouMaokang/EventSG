import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/search_event.dart';
import 'package:event_sg/blocs/search_bloc.dart';
import 'package:event_sg/presentation/sub_pages/search_result_list.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[SearchBar(), SearchResultList()],
      );
  }
}

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  @override
  void initState() {
    super.initState();
    BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(eventRepository: eventRepository));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: TextField(
            controller: _textController,
            autofocus: true,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              hintText: 'Enter a search term',),
            onEditingComplete: () {
              final query = _textController.text;
              BlocProvider.of<SearchBloc>(context).add(FetchEvent(query: query));
            })
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

