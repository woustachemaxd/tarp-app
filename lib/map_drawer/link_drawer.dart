import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/map_drawer/link_drawer/bloc/link_drawer_bloc.dart';
import 'package:navi_repository/navi_repository.dart';

class LinkDrawer extends StatelessWidget {
  const LinkDrawer(
      {super.key,
      required this.child,
      required this.links,
      required this.nodes,
      required this.fromNodeId,
      required this.toNodeId});

  final Widget child;
  final List<Link> links;
  final List<Node> nodes;
  final String fromNodeId;
  final String toNodeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LinkDrawerBloc>(
      create: (context) => LinkDrawerBloc(nodes: nodes, links: links)
        ..add(GetPath(fromNodeId: fromNodeId, toNodeId: toNodeId)),
      child: BlocBuilder<LinkDrawerBloc, LinkDrawerState>(
        builder: (context, state) {
          return Stack(
            children: [
              CustomPaint(
                child: child,
                foregroundPainter: PathPainter(path: state.path),
                size: const Size(1200, 1500),
              ),
              if (state.currPosition != null)
                Positioned(
                  top: state.currPosition!.y - 25,
                  left: state.currPosition!.x - 25,
                  child: IconButton(
                      icon: Icon(Icons.circle,
                          color: Color(0xFFFAFF14),
                          shadows: [
                            Shadow(
                                color: Color.fromARGB(255, 54, 7, 96),
                                blurRadius: 40,
                                offset: Offset(6, 2))
                          ]),
                      onPressed: null,
                      color: Color(0xFFFAFF14)),
                )
            ],
          );
        },
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  PathPainter({required this.path});

  final List<Node> path;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < path.length - 1; i++) {
      canvas.drawLine(
          Offset(path[i].x, path[i].y),
          Offset(path[i + 1].x, path[i + 1].y),
          Paint()
            ..color = Color(0xFFBB97Ef)
            ..strokeWidth = 15);
      canvas.drawCircle(Offset(path[i].x, path[i].y), 7.5,
          Paint()..color = Color(0xFFBB97Ef));
      // canvas.drawRect(
      //     Rect.fromCenter(
      //         center: Offset(path[i].x, path[i].y), width: 20, height: 20),
      //     Paint()..color = Color(0xFFBB97Ef));
    }
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.path != path;
  }
}
