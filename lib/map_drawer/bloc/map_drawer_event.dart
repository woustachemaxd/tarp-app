part of 'map_drawer_bloc.dart';

abstract class MapDrawerEvent extends Equatable {
  const MapDrawerEvent();

  @override
  List<Object> get props => [];
}

class GetNodes extends MapDrawerEvent {
  GetNodes();

}

class GetLinks extends MapDrawerEvent {}
