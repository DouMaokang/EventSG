import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/globals/event_categories.dart';



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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocProvider<SearchBloc>(
          create: (contextC) => SearchBloc(eventRepository: eventRepository),
          child: SingleChildScrollView(
            child: SearchBar()
          )
        ),
      )
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  List<String> interestList = List();
//  List<String> distanceList = ["None","< 1km", "< 5km"];
  List<String> dateList = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday","None"];
  Map<String, String> selectedItems = {"Categories":"", "Distance":"", "Date":""};
  String query = "";
  final _textController = TextEditingController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    EventCategories.eventCategories.forEach((element) => interestList.add(element));
    interestList.add("None");

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
    child: Column(
      children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: new TextField(

            controller: _textController,
            autofocus: false,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                  }),
              hintText: 'Enter a keyword',),
            onEditingComplete: () {
              this.query = _textController.text;
              FocusScope.of(context).unfocus();
            }),
      ),
      SizedBox(height: 16,),
      _buildSelect("Categories", interestList),
//              _buildSelect("Distance", distanceList),
      _buildSelect("Date", dateList),

      SizedBox(height: 30,),

      SizedBox(
        width: double.infinity,
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: Colors.blue,
            child: Text(
              "Search",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          onPressed: () {
              _searchBloc.add(FetchEvent(query: query, filters: selectedItems));
          }),
      )
    ]
    ));
  }

  _buildSelect(String name, List<String> categoryList) {
    return new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,),
              textAlign: TextAlign.left),
          SingleSelectChip(
            categoryList,
            onSelectionChanged: (selectedChoice) {
              setState(() {
                selectedItems[name] = selectedChoice;
                });
            },
          ),
          new Divider(height: 16,),
          SizedBox(height: 4,),
        ],
      ),
    );
  }
}

