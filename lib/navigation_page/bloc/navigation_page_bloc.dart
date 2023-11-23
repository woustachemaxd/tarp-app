import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'navigation_page_event.dart';
part 'navigation_page_state.dart';

class NavigationPageBloc
    extends Bloc<NavigationPageEvent, NavigationPageState> {
  NavigationPageBloc(
      {required String floorId,
      required String fromNodeId,
      required String toNodeId,
      required this.naviRepository})
      : super(NavigationPageState(
            floorId: floorId, fromNodeId: fromNodeId, toNodeId: toNodeId)) {
    on<GetImageId>((event, emit) => _onGetImageId(event, emit));
  }

  final NaviRepository naviRepository;

  void _onGetImageId(
      GetImageId event, Emitter<NavigationPageState> emit) async {
    try {
      Floor floor = await naviRepository.getFloor(id: state.floorId);
      emit(state.copyWith(imageId: floor.imageId));
    } catch (e) {
      print(e);
    }
  }
}
