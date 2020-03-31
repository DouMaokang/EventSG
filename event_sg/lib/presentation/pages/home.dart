import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/presentation/components/loadable_events.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class Homepage extends StatelessWidget {

  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );

  Homepage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {

                BlocProvider.of<EventListBloc>(context)
                    .add(InitializeEventList());

            },
          ),
            title: Text(
              "EventSG",
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
              ),
            ]
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[


          Container(
            decoration: BoxDecoration(color: Colors.pink[50]),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),

              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Upcoming Events",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                    SizedBox(width: 6,),
                    Icon(Icons.event, color: Colors.black, size: 20),
                  ],
                ),
              ),

              subtitle: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "The following events will be happening in 7 days",
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: 6,),

          BlocBuilder<EventListBloc, EventListState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EventListEmpty) {
                BlocProvider.of<EventListBloc>(context)
                    .add(InitializeEventList());
                return Center(
                  child: Text(
                    'Events not loaded!',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is EventListLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EventListLoaded) {
                return BlocProvider<SingleEventBloc>(
                  create: (context) => SingleEventBloc(eventRepository: eventRepository),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return new EventListItem(event: state.upcomingEventList[index], goingToEventDetailsPage: true, key: UniqueKey(),);
                    },
                    itemCount: state.upcomingEventList.length,
                  ),
                );

              } else {
                return Center(
                  child: Text(
                    'Something went wrong!',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            },
          ),

          Divider(),
          Container(
            decoration: BoxDecoration(color: Colors.blue[50]),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),

              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Recommended Events",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                    SizedBox(width: 6,),
                    Icon(Icons.face, color: Colors.black, size: 20,),
                  ],
                ),
              ),

              subtitle: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "The following events are recomended for you based on your interests",
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: 6,),

          BlocBuilder<EventListBloc, EventListState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EventListEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Events not loaded!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              } else if (state is EventListLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EventListLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return new EventListItem(event: state.recommendedEventList[index], goingToEventDetailsPage: true, key: UniqueKey(),);
                  },
                  itemCount: state.recommendedEventList.length,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Something went wrong!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }
            },
          ),

          Divider(),
          Container(
            decoration: BoxDecoration(color: Colors.cyan[50]),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),

              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      "All Events",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                    SizedBox(width: 6,),
                    Icon(Icons.border_all, color: Colors.black, size: 20,),
                  ],
                ),
              ),

              subtitle: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Here is a full list of events",
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 6,),

          BlocBuilder<EventListBloc, EventListState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EventListEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Events not loaded!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              } else if (state is EventListLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EventListLoaded) {
                return LoadableEvents(eventList: state.allEvents,);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Something went wrong!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }
            },
          ),

        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
