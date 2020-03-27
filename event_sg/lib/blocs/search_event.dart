import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class FetchEvent extends SearchEvent {
  final String query;
  final Map<String, String> filters;

  const FetchEvent({@required this.query, this.filters});

  @override
  List<Object> get props => [query, filters];
}