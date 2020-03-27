import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:event_sg/repositories/event_repository.dart';
import 'package:event_sg/models/event.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/blocs/search_event.dart';
import 'package:event_sg/blocs/search_state.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final EventRepository eventRepository;

  SearchBloc({@required this.eventRepository})
      : assert(eventRepository != null);

  @override
  SearchState get initialState => SearchEmpty();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchEvent) {
      yield SearchLoading();
      try {
        final List<Event> event = await eventRepository.getAllEvents();
        yield SearchLoaded(eventList:event);
      } catch (_) {
        yield SearchError();
      }
    }

    if (event is FilterEvent) {

    }
  }
}