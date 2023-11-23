part of 'navigation_page_bloc.dart';

class NavigationPageState extends Equatable {
  const NavigationPageState(
      {required this.floorId,
      required this.fromNodeId,
      required this.toNodeId,
      this.imageId = ""});

  final String fromNodeId;
  final String toNodeId;
  final String floorId;
  final String imageId;

  NavigationPageState copyWith({
    String? fromNodeId,
    String? toNodeId,
    String? floorId,
    String? imageId,
  }) {
    return NavigationPageState(
        floorId: floorId ?? this.floorId,
        fromNodeId: fromNodeId ?? this.fromNodeId,
        toNodeId: toNodeId ?? this.toNodeId ,
        imageId: imageId ?? this.imageId);
  }

  @override
  List<Object> get props => [fromNodeId, toNodeId, floorId, imageId];
}
