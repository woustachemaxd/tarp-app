part of 'search_node_bloc.dart';

abstract class SearchNodeEvent extends Equatable {
  const SearchNodeEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends SearchNodeEvent {
  QueryChanged({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class GetQueryResult extends SearchNodeEvent {}
