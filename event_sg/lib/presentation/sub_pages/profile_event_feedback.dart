
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/globals/login.dart';
import 'package:event_sg/models/event.dart';
import 'package:event_sg/presentation/components/event_list.dart';
import 'package:event_sg/presentation/components/loadable_events.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/blocs/blocs.dart';


class ProfileEventFeedback extends StatelessWidget {
  String userId = Login().getUserId();
  ProfileEventFeedback({Key key}) : super(key: key);
  final EventRepository eventRepository = EventRepository(
      eventApiClient: EventApiClient(httpClient: http.Client())
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventListBloc>(
      create: (contextB) => EventListBloc(eventRepository: eventRepository),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(
                      context
                  );
                },
              ),
              title: Text(
                "Event Feedbacks",
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    BlocProvider.of<EventListBloc>(context)
                        .add(InitializeEventList());
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
                        return new EventListItem(event: state.createdEventList[index], goingToEventDetailsPage: false, key: UniqueKey(),);
                      },
                      itemCount: state.createdEventList.length,
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
          ],
        ),
      ),
    );
  }
}