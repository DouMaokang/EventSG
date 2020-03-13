import 'package:event_sg/components/event_list.dart';
import 'package:event_sg/components/event_list_item.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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

      body: Center(child: buildBody()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: Text('Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget buildBody() {
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
                        )),
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

