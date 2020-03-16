import 'package:event_sg/components/multi_select_chip.dart';
import 'package:event_sg/search_results.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'main.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<String> interestList= ["Cooking", "Art", "Nature", "Business",
    "Volunteer"];
  List<String> distanceList = ["< 1km", "< 5km"];
  List<String> dateList = ["Weekday", "Weekend"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(padding: const EdgeInsets.all(30.0)),
        new TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyBottomNavBar()));
                }),
                hintText: 'Enter a search term',
            ),
          autofocus: true,
          onEditingComplete: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResultsPage()));
            }),
        _buildContainer("Categories", interestList),
        _buildContainer("Distance", distanceList),
        _buildContainer("Date", dateList),
      ],
    );
  }

  _buildContainer(String name, List<String> categoryList){
    return new Container(
      padding: EdgeInsets.fromLTRB(10, 10, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 22,),
              textAlign: TextAlign.left),
          MultiSelectChip(categoryList),
          new Divider()
        ],
      ),
    );
  }


}


