

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../blocs/event_saved_bloc.dart';
import '../../models/event.dart';
import 'event_details.dart';

class EventSaved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventSavedBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Events'),
      ),
      body: StreamBuilder<List<Event>>(
        stream: bloc.favoritesStream,
        // 1
        initialData: bloc.favorites,
        builder: (context, snapshot) {
          // 2
          List<Event> favorites =
          (snapshot.connectionState == ConnectionState.waiting)
              ? bloc.favorites
              : snapshot.data;

          if (favorites == null || favorites.isEmpty) {
            return Center(child: Text('No Saved Events'));
          }

          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final event= favorites[index];
              return EventDetailsPage(eventId: event.eventId);
            },
          );
        },
      ),
    );
  }
}
