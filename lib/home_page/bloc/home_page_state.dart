part of 'home_page_bloc.dart';

enum HomePageStatus {
  buildingPage,
  sourcePage,
  destinationPage,
  navigationPage,
}

class HomePageState extends Equatable {
  const HomePageState(
      {required this.status,
      this.buildingId = "",
      this.fromNodeId = "",
      this.toNodeId = "" ,
      this.floorId = ""});

  final String buildingId;
  final String fromNodeId;
  final String toNodeId;
  final String floorId;
  final HomePageStatus status;

  HomePageState copyWith(
      {HomePageStatus? status,
      String? buildingId,
      String? fromNodeId,
      String? toNodeId,
      String? floorId}) {
    return HomePageState(
      status: status ?? this.status,
      buildingId: buildingId ?? this.buildingId,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      toNodeId: toNodeId ?? this.toNodeId,
      floorId: floorId ?? this.floorId,
    );
  }

  @override
  List<Object> get props => [status, buildingId, fromNodeId, toNodeId , floorId];
}
