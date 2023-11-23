import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'search_node_event.dart';
part 'search_node_state.dart';

class SearchNodeBloc extends Bloc<SearchNodeEvent, SearchNodeState> {
  SearchNodeBloc({required this.naviRepository}) : super(SearchNodeState()) {
    on<QueryChanged>((event, emit) => _onQueryChanged(event, emit));
    on<GetQueryResult>((event, emit) => _onGetQueryResult(event, emit));
  }

  final NaviRepository naviRepository;

  void _onQueryChanged(QueryChanged event, Emitter<SearchNodeState> emit) {
    emit(state.copyWith(query: event.query));
  }

  void _onGetQueryResult(
      GetQueryResult event, Emitter<SearchNodeState> emit) async {
    try {
      emit(state.copyWith(status: SearchNodeStatus.busy));
      List<Node> nodes = await naviRepository.searchNodes(query: state.query);
      emit(state.copyWith(nodes: nodes, status: SearchNodeStatus.notBusy));
    } catch (e) {
      print(e);
    }
  }
}
