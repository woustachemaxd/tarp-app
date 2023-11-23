part of 'building_page_bloc.dart';

abstract class BuildingPageEvent extends Equatable {
  const BuildingPageEvent();

  @override
  List<Object> get props => [];
}


class GetBuildingList extends BuildingPageEvent {
  const GetBuildingList();
}


class BuildingIndexChanged extends BuildingPageEvent {
  const BuildingIndexChanged(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}