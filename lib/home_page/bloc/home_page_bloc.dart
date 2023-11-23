import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState(status: HomePageStatus.buildingPage)) {
    on<ChangeHomePageStatusTo>(
        (event, emit) => _onChangeHomePageStatusTo(event, emit));
    on<BuildingSelected>((event, emit) => _onBuildingSelected(event, emit));
    on<FromNodeSelected>((event, emit) => _onFromNodeSelected(event, emit));
    on<ToNodeSelected>((event, emit) => _onToNodeSelected(event, emit));
  }

  void _onChangeHomePageStatusTo(
      ChangeHomePageStatusTo event, Emitter<HomePageState> emit) {
    emit(HomePageState(status: event.status));
  }

  void _onBuildingSelected(
      BuildingSelected event, Emitter<HomePageState> emit) {
    emit(
        HomePageState(status: HomePageStatus.sourcePage, buildingId: event.id));
  }

  void _onFromNodeSelected(
      FromNodeSelected event, Emitter<HomePageState> emit) {
    emit(state.copyWith(
        status: HomePageStatus.destinationPage,
        fromNodeId: event.id,
        floorId: event.floorId));
  }

  void _onToNodeSelected(ToNodeSelected event, Emitter<HomePageState> emit) {
    emit(state.copyWith(
        status: HomePageStatus.navigationPage, toNodeId: event.id));
  }
}
