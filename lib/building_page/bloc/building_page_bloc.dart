import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'building_page_event.dart';
part 'building_page_state.dart';

class BuildingPageBloc extends Bloc<BuildingPageEvent, BuildingPageState> {
  BuildingPageBloc({required this.naviRepository})
      : super(BuildingPageState(status: BuildingPageStatus.empty)) {
    on<GetBuildingList>((event, emit) => _onGetBuildingList(event, emit));
    on<BuildingIndexChanged>(
        (event, emit) => _onBuildingIndexChanged(event, emit));
  }

  final NaviRepository naviRepository;

  void _onGetBuildingList(
      GetBuildingList event, Emitter<BuildingPageState> emit) async {
    List<Building> buildings;

    try {
      emit(state.copyWith(status: BuildingPageStatus.busy));
      buildings = await naviRepository.getAllBuilding();
      emit(state.copyWith(
        buildings: buildings,
        status: BuildingPageStatus.buildings,
      ));
    } catch (e) {
      emit(state.copyWith(status: BuildingPageStatus.buildings));
      print(e);
    }
  }

  void _onBuildingIndexChanged(
      BuildingIndexChanged event, Emitter<BuildingPageState> emit) {
    print(event.index);
    emit(state.copyWith(index: event.index));
  }
}
