import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:flutter/material.dart';
import './blocs.dart';

class SingleEventBloc extends  Bloc<SingleEventEvent, SingleEventState> {
  final EventRepository eventRepository;

  SingleEventBloc({@required this.eventRepository})
      : assert(eventRepository != null);


  @override
  SingleEventState get initialState => SingleEventEmpty();

  @override
  Stream<SingleEventState> mapEventToState(
    SingleEventEvent uiEvent,
  ) async* {
    if (uiEvent is SingleEventClicked) {
      yield SingleEventLoading();
      try {
        final Event event = await eventRepository.getEventById(uiEvent.eventId);
        yield SingleEventLoaded(event: event);
      } catch(_) {
        yield SingleEventError();
      }
    }
  }
}
