import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/cupertino.dart';
import './blocs.dart';

class EventSavedBloc extends Bloc<EventSavedEvent, EventSavedState> {
  EventRepository eventRepository;

  EventSavedBloc({@required this.eventRepository});

  @override
  EventSavedState get initialState => EventNotSaved();

  @override
  Stream<EventSavedState> mapEventToState(
    EventSavedEvent event,
  ) async* {
    if (event is SaveEvent) {
      eventRepository.likeEvent(eventId: event.eventId, userId: event.userId);
      yield EventSaved();
    } else if (event is UnSaveEvent) {
      eventRepository.unlikeEvent(eventId: event.eventId, userId: event.userId);
      yield EventNotSaved();
    } else if (event is EnterWithSave) {
      yield EventSaved();
    }
  }
}
