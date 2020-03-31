import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:event_sg/globals/login.dart';
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
    if (event is InitializeEventList) {
      yield EventListLoading();
      try {
        print("inside event list bloc: ${Login().getUserId()}");
        final List<Event> upcomingEventList = await eventRepository.getUpcomingEvents(Login().getUserId());
        final List<Event> recommendedEventList = await eventRepository.getRecommendedEvents(Login().getUserId());
        final List<Event> allEvents = await eventRepository.getAllEvents();
        yield EventListLoaded(upcomingEventList: upcomingEventList, recommendedEventList: recommendedEventList, allEvents: allEvents);
      } catch (_) {
        yield EventListError();
      }
    }
  }
}
