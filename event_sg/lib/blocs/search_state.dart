import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sg/models/event.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Event> eventList;

  const SearchLoaded({@required this.eventList }) : assert(eventList != null);

  @override
  List<Object> get props => eventList;
}

class SearchError extends SearchState {}