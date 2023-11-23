part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class ChangeHomePageStatusTo extends HomePageEvent {
  const ChangeHomePageStatusTo({required this.status});

  final HomePageStatus status;

  @override
  List<Object> get props => [status];
}

class BuildingSelected extends HomePageEvent {
  const BuildingSelected({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

class FromNodeSelected extends HomePageEvent {
  const FromNodeSelected({required this.id, required this.floorId});

  final String id;
  final String floorId;

  @override
  List<Object> get props => [id , floorId];
}

class ToNodeSelected extends HomePageEvent {
  const ToNodeSelected({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
