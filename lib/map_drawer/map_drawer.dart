import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/map_drawer/bloc/map_drawer_bloc.dart';
import 'package:navi_app/map_drawer/link_drawer.dart';

import 'package:navi_repository/navi_repository.dart';

class MapDrawer extends StatelessWidget {
  const MapDrawer(
      {super.key,
      required this.floorId,
      required this.child,
      required this.fromNodeId,
      required this.toNodeId});

  final String floorId;
  final Widget child;
  final String fromNodeId;
  final String toNodeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MapDrawerBloc(
            floorId: floorId, naviRepository: context.read<NaviRepository>())
          ..add(GetNodes()),
        child: BlocBuilder<MapDrawerBloc, MapDrawerState>(
          builder: (context, state) {
            return Stack(
              children: [
                if (state.links.isNotEmpty)
                  LinkDrawer(
                    toNodeId: toNodeId,
                    fromNodeId: fromNodeId,
                    links: state.links,
                    nodes: state.nodes,
                    child: child,
                  ),
                ...state.nodes.map((e) {
                  return NodeWidget(
                    node: e,
                  );
                }).toList(),
              ],
            );
          },
        ));
  }
}

class NodeWidget extends StatelessWidget {
  const NodeWidget({super.key, required this.node});

  final Node node;

  @override
  Widget build(BuildContext context) {
    if (node.type == "path") return Container();

    return Positioned(
      top: node.y - 25,
      left: node.x - 25,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          clipBehavior: Clip.none,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.all(2),
              onPressed: null,
              icon: (node.type == "path")
                  ? Icon(Icons.circle)
                  : Image.asset("assets/${node.type}.png"),
            ),
            Positioned(
              // alignment: Alignment.bottomCenter,
              bottom: -15,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color(0xAFFFFFFF),
                    border: Border.all(color: Colors.black)),
                child: Text(
                  node.label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
