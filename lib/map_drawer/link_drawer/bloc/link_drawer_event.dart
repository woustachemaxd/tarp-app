part of 'link_drawer_bloc.dart';

abstract class LinkDrawerEvent extends Equatable {
  const LinkDrawerEvent();

  @override
  List<Object> get props => [];
}

class GetPath extends LinkDrawerEvent {
  const GetPath({required this.fromNodeId, required this.toNodeId});

  final String fromNodeId;
  final String toNodeId;
}

class ScanComplete extends LinkDrawerEvent {
  ScanComplete({required this.accessPoints});

  List<WiFiAccessPoint> accessPoints;

  @override
  List<Object> get props => [accessPoints];
}

class StartScan extends LinkDrawerEvent {}
