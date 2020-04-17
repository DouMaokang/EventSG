import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/presentation/sub_pages/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/models/event.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:http/http.dart' as http;


class SearchResultPage extends StatelessWidget {
  final EventRepository eventRepository = EventRepository(
    // Add all required repositories here.
    eventApiClient: EventApiClient(httpClient: http.Client()),
  );
  final List<Event> eventList;

  SearchResultPage({@required this.eventList});

  @override
  Widget build(BuildContext context) {
    if (eventList == null || eventList.length == 0){
      print("imhere");
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(44.0),
            child: AppBar(
              title: Text("Search Results"),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.error_outline, size: 46,),
                SizedBox(height: 24,),
                Text(
                    "Sorry, we didn't find any events",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                  ),

              ],
            ),
          )
      );
    } else{
      return BlocProvider<SingleEventBloc>(
          create: (context) => SingleEventBloc(eventRepository: eventRepository),
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Search"),
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.blue[50]),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),

                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Search Results",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            SizedBox(width: 6,),
                            Icon(Icons.widgets, color: Colors.black, size: 20),
                          ],
                        ),
                      ),

                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "We have found ${eventList.length} related events for you",
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
                  SizedBox(height: 8,),
                  ListView.builder(
                      itemCount: eventList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return EventListItem(
                          event: eventList[index], goingToEventDetailsPage: true,
                        );
                      }),
                ],
              )
          ));
    }
  }
}
