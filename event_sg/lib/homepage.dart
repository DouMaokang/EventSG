import 'package:event_sg/components/event_list.dart';
import 'package:event_sg/components/event_list_item.dart';
import 'package:event_sg/search_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title}) : super(key: key);

  final String title;
  List<EventListItem> recommendedEventList = [];
  List<EventListItem> upcomingEventList = [];


  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    widget.upcomingEventList.add(EventListItem(
      eventVenue: "NTU", eventDate: "May 1", eventName: "Event1",));
    for (var i = 0; i < 20; i++) {
      widget.recommendedEventList.add(EventListItem(
        eventVenue: "NTU", eventDate: "May 1", eventName: "Event1",));
    }

    return Scaffold(
      appBar: AppBar(
          title: Text("Homepage"),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                //TODO On pressed go to saved events page
              },
            ),
          ]
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()));
                    },),
                    new RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Upcoming Events",
                              style: TextStyle(color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22)),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0),
                              child: Icon(Icons.notifications),
                            )
                          )
                        ]
                      )
                    ),
                    EventList(itemList: widget.upcomingEventList),
                    new Padding(padding: const EdgeInsets.all(12.0)),
                    Text("Recommended Events", style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                    EventList(itemList: widget.recommendedEventList),
                  ],
              );
          }
}

