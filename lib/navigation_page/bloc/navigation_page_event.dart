part of 'navigation_page_bloc.dart';

abstract class NavigationPageEvent extends Equatable {
  const NavigationPageEvent();

  @override
  List<Object> get props => [];
}


class GetImageId extends NavigationPageEvent {}