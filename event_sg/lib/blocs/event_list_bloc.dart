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
        final List<Event> upcomingEventList = await eventRepository.getUpcomingEvents(Login().getUserId());
        print("1111111111111111111");

        final List<Event> recommendedEventList = await eventRepository.getRecommendedEvents(Login().getUserId());
        print("2111111111111111111");

        final List<Event> allEvents = await eventRepository.getAllEvents();
        print("3111111111111111111");

        final List<Event> createdEventList = await eventRepository.getOrganizedEvents(Login().getUserId());
        print("4111111111111111111");

        final List<Event> registeredEventList = await eventRepository.getRegisteredEvents(Login().getUserId());
        print("5111111111111111111");

        final List<Event> savedEventList = await eventRepository.getSavedEvents(Login().getUserId());
        print("6111111111111111111");

        yield EventListLoaded(upcomingEventList: upcomingEventList, recommendedEventList: recommendedEventList, allEvents: allEvents, registeredEventList: registeredEventList, createdEventList: createdEventList, savedEventList: savedEventList);
      } catch (_) {
        yield EventListError();
      }
    }
  }
}
