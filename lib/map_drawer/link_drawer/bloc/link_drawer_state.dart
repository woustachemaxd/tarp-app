part of 'link_drawer_bloc.dart';

class LinkDrawerState extends Equatable {
  const LinkDrawerState({this.path = const [] , this.currPosition});

  final List<Node> path;
  final Node? currPosition;

  LinkDrawerState copyWith({List<Node>? path , Node? currPosition}) {
    return LinkDrawerState(path: path ?? this.path , currPosition: currPosition ?? this.currPosition);
  }

  @override
  List<Object?> get props => [path , currPosition];
}
