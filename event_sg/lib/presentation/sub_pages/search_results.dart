
import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  SearchResultsPage({Key key}) : super(key: key);

  List<EventListItem> resultsList = [];

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
//    for (var i = 0; i < 5; i++) {
//      widget.resultsList.add(EventListItem(
//        eventVenue: "NTU", eventDate: "May 1", eventName: "Event1",));
//    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
      ),

      body: _buildBody(),
    );
  }

  _buildBody() {
    return new ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      children: <Widget>[
        new TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: 'Enter a search term'
          ),
          onTap: (){
            Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()));
          },),

        new Padding(padding: const EdgeInsets.all(12.0)),
        Text("Results", style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 22)),
        // EventList(itemList: widget.resultsList),
      ],
    );
  }
}