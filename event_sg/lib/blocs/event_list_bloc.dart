import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/material.dart';
import './blocs.dart';


/// A business logic component that listens to UI events and update UI states.
class EventListBloc extends Bloc<EventListEvent, EventListState> {
  final EventRepository eventRepository;

  EventListBloc({@required this.eventRepository})
      : assert(eventRepository != null);


  @override
  EventListState get initialState => EventListEmpty();

  @override
  Stream<EventListState> mapEventToState(
    EventListEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetAllEvents) {
      yield EventListLoading();
      try {
        final List<Event> eventList = await eventRepository.getAllEvents();
        yield EventListLoaded(eventList: eventList);
      } catch (_) {
        yield EventListError();
      }
    }
  }
}
