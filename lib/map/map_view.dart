import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/map/bloc/map_bloc.dart';
import 'package:navi_app/map_drawer/map_drawer.dart';

import 'package:navi_repository/navi_repository.dart';

class MapView extends StatelessWidget {
  const MapView(
      {super.key,
      required this.floorId,
      required this.imageId,
      this.tc,
      required this.refresh,
      required this.fromNodeId,
      required this.toNodeId});

  final String floorId;
  final String imageId;
  final TransformationController? tc;
  final String fromNodeId;
  final String toNodeId;
  final int refresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) {
        return MapBloc(
          naviRepository: context.read<NaviRepository>(),
        )..add(getNewMap(imageId: imageId, floorId: floorId));
      },
      child: MapViewer(
        toNodeId: toNodeId,
        fromNodeId: fromNodeId,
        tc: tc,
      ),
    );
  }
}

class MapViewer extends StatelessWidget {
  const MapViewer(
      {super.key, this.tc, required this.fromNodeId, required this.toNodeId});
  final TransformationController? tc;
  final String fromNodeId;
  final String toNodeId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is NoMapSelectedState) {
          return Center(child: Text("Nothing to show"));
        }

        if (state is MapLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
            child: IntercativeMap(
          toNodeId: toNodeId,
          fromNodeId: fromNodeId,
          state: state as MapDataState,
          tc: tc,
        ));
      },
    );
  }
}

class IntercativeMap extends StatelessWidget {
  const IntercativeMap(
      {super.key,
      required this.state,
      this.tc,
      required this.fromNodeId,
      required this.toNodeId});

  final MapDataState state;
  final TransformationController? tc;
  final String fromNodeId;
  final String toNodeId;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController:tc,
      // constrained: (tc == null) ? true : false,
      constrained: false,
      maxScale: 100,
      // boundaryMargin: EdgeInsets.all(60),
      child: SizedBox(
          width: 1200,
          height: 1500,
          child: MapDrawer(
            toNodeId: toNodeId,
            fromNodeId: fromNodeId,
            floorId: state.floorId,
            child: Image.memory(
              state.imageBuffer,
              width: 1200,
              height: 1500,
            ),
          )),
    );
  }
}
