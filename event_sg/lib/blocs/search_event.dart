import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class FetchEvent extends SearchEvent {
  final String query;

  const FetchEvent({@required this.query}) : assert(query != null);

  @override
  List<Object> get props => [query];
}

class FilterEvent extends SearchEvent {
  final List<String> filters;

  const FilterEvent({@required this.filters});

  @override
  List<Object> get props => [filters];
}