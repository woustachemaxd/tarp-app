part of 'building_page_bloc.dart';

enum BuildingPageStatus {
  busy,
  empty,
  buildings,
  error,
}

class BuildingPageState extends Equatable {
  const BuildingPageState({this.buildings = const [], this.index = 0 , required this.status});

  final List<Building> buildings;
  final int index;
  final BuildingPageStatus status;

  BuildingPageState copyWith({List<Building>? buildings, int? index , BuildingPageStatus? status}) {
    return BuildingPageState(
        buildings: buildings ?? this.buildings, index: index ?? this.index  , status:  status ?? this.status);
  }

  @override
  List<Object> get props => [buildings, index];
}
