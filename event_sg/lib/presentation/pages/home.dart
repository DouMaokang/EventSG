import 'package:event_sg/api_clients/event_api_client.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/components/components.dart';
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
      body: new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[

          SizedBox(height: 16,),
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
          BlocBuilder<EventListBloc, EventListState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EventListEmpty) {
//              BlocProvider.of<EventListBloc>(context)
//                  .add(InitializeEventList());
                return Text("Empty");
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
                      return new EventListItem(event: state.upcomingEventList[index], key: UniqueKey(),);
                    },
                    itemCount: state.upcomingEventList.length,
                  ),
                );
              } else {
                return Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
                );
              }
            },
          ),
          SizedBox(height: 24,),
          Text("Recommended Events", style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 22)),
          BlocBuilder<EventListBloc, EventListState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EventListEmpty) {
                BlocProvider.of<EventListBloc>(context)
                    .add(InitializeEventList());
                return Text("Hello");
              } else if (state is EventListLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is EventListLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return new EventListItem(event: state.recommendedEventList[index], key: UniqueKey(),);
                  },
                  itemCount: state.recommendedEventList.length,
                );
              } else {
                return Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
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
