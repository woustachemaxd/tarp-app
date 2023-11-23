import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';
import 'package:wifi_scan/wifi_scan.dart';

part 'link_drawer_event.dart';
part 'link_drawer_state.dart';

class LinkDrawerBloc extends Bloc<LinkDrawerEvent, LinkDrawerState> {
  LinkDrawerBloc({required List<Node> nodes, required List<Link> links})
      : super(LinkDrawerState()) {
    _init();
    for (Node node in nodes) {
      nodeMap.addAll({node.id!: node});

      if (node.ssid != null) {
        ssidMap.addAll({node.ssid!: node});
      }
    }

    for (Link link in links) {
      if (graph.containsKey(link.link1Id)) {
        graph[link.link1Id]!.add(link.link2Id);
      } else {
        graph.addAll({
          link.link1Id: [link.link2Id]
        });
      }

      if (graph.containsKey(link.link2Id)) {
        graph[link.link2Id]!.add(link.link1Id);
      } else {
        graph.addAll({
          link.link2Id: [link.link1Id]
        });
      }
    }

    on<GetPath>((event, emit) => _onGetPath(event, emit));
    on<StartScan>((event, emit) => _onStartScan(event, emit));
    on<ScanComplete>((event, emit) => _onScanComplete(event, emit));
  }

  late StreamSubscription<List<WiFiAccessPoint>>? subscription;
  late Timer scanner;

  @override
  Future<void> close() {
    subscription?.cancel();
    scanner.cancel();
    return super.close();
  }

  void _init() async {
    final can =
        await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        subscription =
            WiFiScan.instance.onScannedResultsAvailable.listen((results) {
          add(ScanComplete(accessPoints: results));
        });
        break;

      default:
        print("---- CAN NOT GET RESULT---");
    }

    scanner = Timer.periodic(Duration(seconds: 3), (timer) {
      add(StartScan());
    });
  }

  void _onStartScan(StartScan event, Emitter<LinkDrawerState> emit) async {
    final can = await WiFiScan.instance.canStartScan(askPermissions: true);
    switch (can) {
      case CanStartScan.yes:
        final isScanning = await WiFiScan.instance.startScan();
        print(isScanning);

        break;
      default:
        print("---CAN NOT SCAN---");
    }
  }

  void _onScanComplete(ScanComplete event, Emitter<LinkDrawerState> emit) {
    //code to get position here,
    //first sort the on the basis of rssi
    event.accessPoints.sort(((a, b) {
      return b.level.compareTo(a.level);
    }));
    for (var wifi in event.accessPoints) {
      if (wifi.ssid.contains("VIT")) {
        if (ssidMap.containsKey(wifi.bssid)) {
          emit(state.copyWith(currPosition: ssidMap[wifi.bssid]));
          break;
        }
      }
    }
    //then check if its in the map
    print("Scan Complete");
  }

  Map<String, Node> nodeMap = {};
  Map<String, List<String>> graph = {};
  Map<String, Node> ssidMap = {};

  void _onGetPath(GetPath event, Emitter<LinkDrawerState> emit) {
    Queue<String> queue = Queue();
    Set<String> visited = {};
    Map<String, String> parent = {};
    bool found = false;

    if (graph.isEmpty) return;

    queue.add(event.fromNodeId);
    parent.addAll({event.fromNodeId: "Start"});
    print(graph.length);

    while (queue.isNotEmpty) {
      String curr = queue.removeFirst();

      visited.add(curr);

      for (String nei in graph[curr]!) {
        if (visited.contains(nei)) continue;
        parent.addAll({nei: curr});
        if (nei == event.toNodeId) {
          found = true;
          break;
        }
        queue.addLast(nei);
      }
      if (found) {
        break;
      }
    }

    List<Node> path = [nodeMap[event.toNodeId]!];
    if (found) {
      print("yes------------------->");
      String temp = event.toNodeId;
      int i = 0;
      while (true) {
        String p = parent[temp]!;
        print(p);
        if (p == "Start") {
          break;
        }
        path.add(nodeMap[p]!);
        temp = p;
        if (i == 100) {
          break;
        }
        i++;
      }

      print(i);

      emit(state.copyWith(path: path));
    }
  }
}
