import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/home_page/bloc/home_page_bloc.dart';
import 'package:navi_app/search_node/bloc/search_node_bloc.dart';
import 'package:navi_repository/navi_repository.dart';

class DestPage extends StatelessWidget {
  const DestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchNodeBloc>(
      create: (context) =>
          SearchNodeBloc(naviRepository: context.read<NaviRepository>()),
      child: BlocBuilder<SearchNodeBloc, SearchNodeState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Where do you want to go?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        context.read<HomePageBloc>().add(ChangeHomePageStatusTo(
                            status: HomePageStatus.sourcePage));
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(label: Text("Room")),
                        onChanged: (value) => context
                            .read<SearchNodeBloc>()
                            .add(QueryChanged(query: value)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Search"),
                      onPressed: () =>
                          context.read<SearchNodeBloc>().add(GetQueryResult()),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: state.nodes.length,
                  itemBuilder: (context, index) => ListTile(
                      title: Text(state.nodes[index].label),
                      subtitle: Text(
                        state.nodes[index].desc,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Image.asset(
                        "assets/${state.nodes[index].type}.png",
                        width: 30,
                        height: 30,
                      ),
                      onTap: () => context
                          .read<HomePageBloc>()
                          .add(ToNodeSelected(id: state.nodes[index].id!))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
