import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/presentation/components/components.dart';


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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SearchBar(),
            ],
          )
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

  List<String> interestList = ["None", "Cooking", "Art", "Nature",
    "Volunteer", "School"];
//  List<String> distanceList = ["None","< 1km", "< 5km"];
  List<String> dateList = ["None","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  Map<String, String> selectedItems = {"Categories":"", "Distance":"", "Date":""};
  String query = "";
  final _textController = TextEditingController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
    listener: (context, state) {
      if (state is SearchLoaded) {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => SearchResultPage(eventList: state.eventList)));
          return null;
      }
    },
    child: new SingleChildScrollView(
            child: Column(
              children: <Widget>[
              new TextField(
                  controller: _textController,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    hintText: 'Enter a search term',),
                  onEditingComplete: () {
                    this.query = _textController.text;
                    FocusScope.of(context).unfocus();
                  }),
              _buildSelect("Categories", interestList),
//              _buildSelect("Distance", distanceList),
              _buildSelect("Date", dateList),
              new Container(
                margin: EdgeInsets.all(2),
                child: FlatButton(
                  child: Text('Search'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                      _searchBloc.add(FetchEvent(query: query, filters: selectedItems));
                  }))
            ]
            )
    ));
  }

  _buildSelect(String name, List<String> categoryList) {
    return new Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,),
              textAlign: TextAlign.left),
          MultiSelectChip(
            categoryList,
            onSelectionChanged: (selectedChoice) {
              setState(() {
                selectedItems[name] = selectedChoice;
                });
            },
          ),
          new Divider()
        ],
      ),
    );
  }
}

