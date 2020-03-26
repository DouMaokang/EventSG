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