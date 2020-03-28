import 'package:bloc/bloc.dart';
import 'package:event_sg/blocs/post_event_event.dart';
import 'package:event_sg/blocs/post_event_state.dart';
import 'package:event_sg/repositories/event_repository.dart';
import 'package:flutter/cupertino.dart';

class PostEventBloc extends Bloc<PostEventEvent,PostEventState> {
  final EventRepository eventRepository;

  PostEventBloc(this.eventRepository);

  @override
  // TODO: implement initialState
  PostEventState get initialState => PostEventState();

  @override
  Stream<PostEventState> mapEventToState(PostEventEvent event) {
    // TODO: implement mapEventToState
    if (event is PostEventNext) {

    }
    return null;
  }

}