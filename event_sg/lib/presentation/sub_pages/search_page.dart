import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/search_event.dart';
import 'package:event_sg/blocs/search_bloc.dart';
import 'package:event_sg/presentation/sub_pages/search_result_page.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/presentation/components/components.dart';

import '../components/components.dart';

class SearchPage extends StatelessWidget {
  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: BlocProvider<SearchBloc>(
        create: (contextC) => SearchBloc(eventRepository: eventRepository),
        child: Column(
          children: <Widget>[
            SearchBar(),
            SearchFilter()
          ],
        )
      )
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  SearchBloc _searchBloc;


  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
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
//              BlocProvider.of<SearchBloc>(context).add(FetchEvent(query: query));
                  _searchBloc.add(FetchEvent(query: query));
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchResultPage()));
                })
        );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class SearchFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

  List<String> interestList = ["Cooking", "Art", "Nature", "Business",
    "Volunteer"];
  List<String> distanceList = ["< 1km", "< 5km"];
  List<String> dateList = ["Weekday", "Weekend"];
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildContainer("Categories", interestList),
        _buildContainer("Distance", distanceList),
        _buildContainer("Date", dateList),
      ],
    );
  }


  _buildMultiselect(String name, List<String> categoryList) {
    return new Container(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 22,),
              textAlign: TextAlign.left),
          MultiSelectChip(
            categoryList,
            onSelectionChanged: (selectedList) {
              setState(() {
                 selectedList;
              });
            },
          ),
          new Divider()
        ],
      ),
    );
  }
}

