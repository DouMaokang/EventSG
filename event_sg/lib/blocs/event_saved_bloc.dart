import 'dart:async';

import '../models/event.dart';
import 'package:bloc/bloc.dart';


class EventSavedBloc implements Bloc {
  var _event = <Event>[];
  List<Event> get favorites => _event;

  final _controller = StreamController<List<Event>>.broadcast();
  Stream<List<Event>> get favoritesStream => _controller.stream;

  void toggleRestaurant(Event event) {
    if (_event.contains(event)) {
      _event.remove(event);
    } else {
      _event.add(event);
    }

    _controller.sink.add(_event);
  }

  @override
  void dispose() {
    _controller.close();
  }
}