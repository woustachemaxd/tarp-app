part of 'search_node_bloc.dart';

enum SearchNodeStatus { busy, error, notBusy }

class SearchNodeState extends Equatable {
  const SearchNodeState({
    this.nodes = const [],
    this.query = "",
    this.status = SearchNodeStatus.notBusy,
  });

  final List<Node> nodes;
  final String query;
  final SearchNodeStatus status;

  SearchNodeState copyWith(
      {List<Node>? nodes, String? query, SearchNodeStatus? status}) {
    return SearchNodeState(
        query: query ?? this.query,
        nodes: nodes ?? this.nodes,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [nodes, query, status];
}
