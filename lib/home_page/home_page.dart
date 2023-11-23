import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/building_page/building_page.dart';
import 'package:navi_app/dest_page/dest_page.dart';
import 'package:navi_app/home_page/bloc/home_page_bloc.dart';
import 'package:navi_app/navigation_page/navigation_page.dart';
import 'package:navi_app/source_page/manual_source_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: Scaffold(body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state.status == HomePageStatus.buildingPage) {
            return BuildingPage();
          } else if (state.status == HomePageStatus.sourcePage) {
            return SafeArea(child: ManualSourcePage());
          } else if (state.status == HomePageStatus.destinationPage) {
            return SafeArea(child: DestPage());
          }

          return NavigationPage(
              floorId: state.floorId,
              fromNodeId: state.fromNodeId,
              toNodeId: state.toNodeId);
        },
      )),
    );
  }
}
