import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/home_page/bloc/home_page_bloc.dart';
import 'package:navi_app/map/map_view.dart';
import 'package:navi_app/navigation_page/bloc/navigation_page_bloc.dart';
import 'package:navi_repository/navi_repository.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage(
      {super.key,
      required this.floorId,
      required this.fromNodeId,
      required this.toNodeId});

  final String fromNodeId;
  final String toNodeId;
  final String floorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationPageBloc>(
      create: (context) => NavigationPageBloc(
          floorId: floorId,
          fromNodeId: fromNodeId,
          toNodeId: toNodeId,
          naviRepository: context.read<NaviRepository>())
        ..add(GetImageId()),
      child: BlocBuilder<NavigationPageBloc, NavigationPageState>(
        builder: (context, state) {
          if (state.imageId == "")
            return Center(
              child: CircularProgressIndicator(),
            );

          return Stack(
            children: [
              MapView(
                floorId: floorId,
                imageId: state.imageId,
                refresh: 0,
                toNodeId: toNodeId,
                fromNodeId: fromNodeId,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_sharp),
                    iconSize: 30,
                    onPressed: () => context.read<HomePageBloc>().add(
                        ChangeHomePageStatusTo(
                            status: HomePageStatus.destinationPage)),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
