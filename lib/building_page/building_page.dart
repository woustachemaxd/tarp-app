import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/building_page/bloc/building_page_bloc.dart';
import 'package:navi_app/home_page/bloc/home_page_bloc.dart';
import 'package:navi_repository/navi_repository.dart';
import 'package:cross_file_image/cross_file_image.dart';

class BuildingPage extends StatelessWidget {
  const BuildingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuildingPageBloc>(
      create: (context) =>
          BuildingPageBloc(naviRepository: context.read<NaviRepository>())
            ..add(GetBuildingList()),
      child: BlocBuilder<BuildingPageBloc, BuildingPageState>(
        builder: (context, state) {
          if (state.status == BuildingPageStatus.busy)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (state.buildings.isEmpty)
            return Center(
              child: Text("No buildings found"),
            );

          return Stack(
            children: [
              PageView.builder(
                itemCount: state.buildings.length,
                itemBuilder: (context, index) {
                  // return Center(
                  //   child: Text(state.buildings[index].name),
                  // );
                  return FutureBuilder(
                    future: state.buildings[index].imageFile.readAsBytes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Can Not load Image"),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
                onPageChanged: (value) => context
                    .read<BuildingPageBloc>()
                    .add(BuildingIndexChanged(value)),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Card(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Where are you?",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    state.buildings[state.index].name,
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text("Next"),
                              onPressed: () {
                                context.read<HomePageBloc>().add(
                                    BuildingSelected(
                                        id: state.buildings[state.index].id!));
                              },
                            ),
                          )
                        ]),
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
