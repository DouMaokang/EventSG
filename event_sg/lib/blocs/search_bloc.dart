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
        final Map<String, String> filters = event.filters;
        final String query = event.query;
        List<Event> queriedEvents;

        // if a query is not empty, query by keywords first and then filter using filters
        if(query != "")
          queriedEvents = await eventRepository.searchEventByTitle(query);
        else
          queriedEvents = await eventRepository.getAllEvents();

        // if category filter is set:
        if(filters["Categories"] != "" && filters["Categories"] != "None")
          queriedEvents = queriedEvents.where((i) => (i.category == filters["Categories"])).toList();
        //  if distance filter is set:

        if(filters["Date"] != "" && filters["Date"] != "None")
          {
            Map<String, int> dayToNum = {"Monday":1, "Tuesday":2, "Wednesday":3,
                            "Thursday":4, "Friday":5, "Saturday":6, "Sunday":7};
            queriedEvents = queriedEvents.where((i) => (i.startTime.weekday == dayToNum[filters["Date"]])).toList();
          }

        print(queriedEvents);
        yield SearchLoaded(eventList:queriedEvents);
      } catch (_) {
        yield SearchError();
      }
    }
  }
}