<<<<<<< HEAD
//최소 거리 길찾기 결과
/* 12.05 결국 라인 교집합일때의 조건을 해결 못함
거꾸로 갈때의 시간이 이상함

해보려고 했지만 할 수 없음
 */
//12.06 모든게 잘 나오는 듯 싶음
=======
//최소 시간 길찾기
// 정욱이가 처음부터 끝까지 다함
>>>>>>> 738d089bc3b21deeebda6b7f07adfb3dd760f464
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/FindWay/minimumTransfer.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/findWay.dart';
import 'package:flutter_application_1/FIndWay/minimumDistance.dart';
import 'package:flutter_application_1/FIndWay/WriteStation.dart';

import '../util/firebaseUtil.dart';

class MinimumTransfer extends StatefulWidget {
  final String startStation;
  final String endStation;

  const MinimumTransfer({
    Key? key,
    required this.startStation,
    required this.endStation,
  }) : super(key: key);

  @override
  _MinimumTransferState createState() => _MinimumTransferState();
}

class _MinimumTransferState extends State<MinimumTransfer> {
  late Future<Map<String, dynamic>?> startStationData;
  late Future<Map<String, dynamic>?> endStationData;
  static Map<String, List<Map<String, dynamic>>> graph = {};
  static bool graphBuilt = false;

  bool isMinDistanceSelected = false;
<<<<<<< HEAD
=======
  
>>>>>>> 738d089bc3b21deeebda6b7f07adfb3dd760f464

  @override
  void initState() {
    super.initState();
    startStationData = fetchStationData(widget.startStation);
    endStationData = fetchStationData(widget.endStation);

    if (!graphBuilt) {
      buildGraph();
    }
  }

  //그래프 생성 함수
  Future<void> buildGraph() async {
    if (graphBuilt) return;

    try {
      final stationsSnapshot =
          await FirebaseFirestore.instance.collection('station').get();
      for (var doc in stationsSnapshot.docs) {
        final data = doc.data();
        if (data.containsKey('routeInfo')) {
          final routeInfo = data['routeInfo'];
          String startStation = routeInfo['startStation'].toString();
          String endStation = routeInfo['endStation'].toString();
          int distance = routeInfo['distance'];
          int duration = routeInfo['duration'];
          int cost = routeInfo['cost'];

          graph.putIfAbsent(startStation, () => []);
          graph[startStation]!.add({
            'station': endStation,
            'distance': distance,
            'duration': duration,
            'cost': cost,
          });

          graph.putIfAbsent(endStation, () => []);
          graph[endStation]!.add({
            'station': startStation,
            'distance': distance,
            'duration': duration,
            'cost': cost,
          });
        }
      }

      graphBuilt = true;
    } catch (e) {
      print("그래프를 생성하는 동안 오류 발생: $e");
    }
  }

  //다익스트라 알고리즘 함수
  Future<Map<String, dynamic>> dijkstra(
      String startStation, String endStation) async {
    if (!graph.containsKey(startStation) || !graph.containsKey(endStation)) {
      return {};
    }

    Map<String, double> distances = {};
    Map<String, double> durations = {};
    Map<String, double> costs = {};
    Map<String, String?> previousNodes = {};
    Set<String> visited = {};

    // 초기화
    for (var station in graph.keys) {
      distances[station] = double.infinity;
      durations[station] = double.infinity;
      costs[station] = double.infinity;
      previousNodes[station] = null;
    }

    durations[startStation] = 0;
    distances[startStation] = 0;
    costs[startStation] = 0;

    List<MapEntry<String, double>> queue = [];
    queue.add(MapEntry(startStation, 0)); // 최소 시간 기준으로 시작

    while (queue.isNotEmpty) {
      // 큐를 정렬 후 최소 시간 노드 선택
      queue.sort((a, b) => a.value.compareTo(b.value));
      final current = queue.removeAt(0).key;

      if (visited.contains(current)) continue;
      visited.add(current);

      // 인접 노드 탐색
      for (var neighbor in graph[current] ?? []) {
        String nextStation = neighbor['station'];
        int edgeDistance = neighbor['distance'];
        int edgeDuration = neighbor['duration'];
        int edgeCost = neighbor['cost'];

        if (visited.contains(nextStation)) continue;

        // 현재 노드에서 다음 노드로 가는 누적 시간
        double newDuration = durations[current]! + edgeDuration;

        // 최소 시간 기준 업데이트
        if (newDuration < durations[nextStation]!) {
          durations[nextStation] = newDuration;
          distances[nextStation] = distances[current]! + edgeDistance;
          costs[nextStation] = costs[current]! + edgeCost;
          previousNodes[nextStation] = current;
          queue.add(MapEntry(nextStation, newDuration));
        }
      }
    }

    // 경로 구성
    List<String> path = [];
    String? currentNode = endStation;
    while (currentNode != null) {
      path.insert(0, currentNode);
      currentNode = previousNodes[currentNode];
    }

    print("경로: $path");

    Map<String, List<int>> lineData = await fetchLineData(path); // 라인 정보 가져오기
    int transferCount = calculateTransfers(lineData); // 환승 횟수 계산

    List<Map<String, dynamic>> uiDetails = await generateUIDetails(
      path,
      lineData,
      durations,
    );

    return {
      "distance": distances[endStation]!, // 총 거리
      "duration": durations[endStation]!, // 최소 시간
      "cost": costs[endStation]!, // 총 비용
      "path": uiDetails, // 경로 상세 정보
      "transferCount": transferCount, // 환승 횟수
    };
  }

  //path에 담긴 경로에 해당하는 라인값을 lineData에 담음
  Future<Map<String, List<int>>> fetchLineData(List<String> path) async {
    Map<String, List<int>> lineData = {};

    for (int i = 0; i < path.length; i++) {
      final stationData = await fetchStationData(path[i]);

      if (stationData != null && stationData.containsKey('line')) {
        List<int> currentLines = List<int>.from(stationData['line']);

        if (i < path.length - 1) {
          final nextStationData = await fetchStationData(path[i + 1]);

          if (nextStationData != null && nextStationData.containsKey('line')) {
            List<int> nextLines = List<int>.from(nextStationData['line']);
            List<int> commonLines =
                currentLines.where((line) => nextLines.contains(line)).toList();

            lineData[path[i]] =
                commonLines.isNotEmpty ? commonLines : currentLines;
          } else {
            lineData[path[i]] = currentLines;
          }
        } else {
          lineData[path[i]] = currentLines;
        }
      } else {
        lineData[path[i]] = [];
      }
    }

    return lineData;
  }

  //환승횟수세기
  int calculateTransfers(Map<String, List<int>> lineData) {
    int transferCount = 0;
    List<int> currentLines = lineData.entries.first.value;

    for (var entry in lineData.entries.skip(1)) {
      if (currentLines.every((line) => !entry.value.contains(line))) {
        transferCount++;
        currentLines = entry.value;
      }
    }

    return transferCount;
  }

//durations(누적 소요시간 값)을 그냥 받아와서 그 전 durations를 뺴는걸로...
//findway에 값을 넘겨주기 위한 함수
  Future<List<Map<String, dynamic>>> generateUIDetails(
    List<String> path,
    Map<String, List<int>> lineData,
    Map<String, double> durations, // duration 값을 받음
  ) async {
    List<Map<String, dynamic>> uiDetails = [];
    List<int> currentLines = lineData[path.first] ?? [];
    double accumulatedDuration = 0; // 누적 duration 저장 변수
    int lastTransferIndex = 0; // 마지막 환승 발생 지점 인덱스 저장

    // Firebase에서 특정 역 정보 가져오는 함수
    Future<Map<String, dynamic>> fetchStationDetails(String stationName) async {
      final snapshot = await FirebaseFirestore.instance
          .collection('station')
          .doc(stationName)
          .get();
      return snapshot.data() ?? {};
    }

    // 첫 출발역 추가
    final firstStationDetails = await fetchStationDetails(path.first);
    uiDetails.add({
      "line": currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
      "stationName": path.first,
      "quickExit": firstStationDetails['stationDetails']?['quickExit'] ?? "",
      "doorSide": "", // 첫 출발역에서는 내리는 문 정보 없음
      "duration": "", // 초기값
    });

    // 경로 순회하면서 환승 정보를 추가
    for (int i = 1; i < path.length; i++) {
      // 현재 구간의 누적 duration 계산
      if (i > lastTransferIndex) {
        accumulatedDuration =
            durations[path[i]]! - durations[path[lastTransferIndex]]!;
      } else {
        accumulatedDuration += durations[path[i]]!;
      }

      // 환승이 발생한 경우
      if (currentLines
          .every((line) => !(lineData[path[i]] ?? []).contains(line))) {
        // 환승 전 도착역
        final prevStationDetails = await fetchStationDetails(path[i]);
        uiDetails.add({
          "line":
              currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
          "stationName": path[i],
          "quickExit": "",
          "doorSide": prevStationDetails['facilityInfo']?['doorSide'] ?? "",
          "duration": accumulatedDuration.toInt(),
        });

        // 누적 duration 초기화 및 환승 지점
        accumulatedDuration = 0;
        lastTransferIndex = i;
        currentLines = lineData[path[i]] ?? [];

        // 환승 후 출발역
        final nextStationDetails = await fetchStationDetails(path[i]);
        uiDetails.add({
          "line":
              currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
          "stationName": path[i],
          "quickExit": nextStationDetails['stationDetails']?['quickExit'] ?? "",
          "doorSide": "",
          "duration": "",
        });
      }
    }

    // 최종 도착역 추가
    final lastStationDetails = await fetchStationDetails(path.last);
    uiDetails.add({
      "line": currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
      "stationName": path.last,
      "quickExit": "",
      "doorSide": lastStationDetails['facilityInfo']?['doorSide'] ?? "",
      "duration": accumulatedDuration.toInt(),
    });

    return uiDetails;
  }

<<<<<<< HEAD
=======
  @override
>>>>>>> 738d089bc3b21deeebda6b7f07adfb3dd760f464
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
<<<<<<< HEAD
            // WriteStation 페이지로 이동
=======
>>>>>>> 738d089bc3b21deeebda6b7f07adfb3dd760f464
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteStationPage(
<<<<<<< HEAD
                  initialStartStation: widget.startStation,
                  initialEndStation: widget.endStation,
                  searchHistory: [],
                ),
              ),
            );
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text('길찾기').tr(),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: Future.wait([startStationData, endStationData]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("데이터를 불러오는 중 오류가 발생했습니다."));
          } else if (!snapshot.hasData || snapshot.data!.length < 2) {
            return Center(
              child: Text("출발역 또는 도착역 정보를 찾을 수 없습니다."),
=======
                  initialStartStation:
                      widget.startStation, // 전달할 startStation 값
                  initialEndStation: widget.endStation, // 전달할 endStation 값
                  searchHistory: [], // 필요한 경우 검색 기록 전달
                ),
              ),
>>>>>>> 738d089bc3b21deeebda6b7f07adfb3dd760f464
            );
          },
          child:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          '길찾기',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 60.0,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ).tr(),
        backgroundColor: const Color.fromARGB(204, 34, 83, 111),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: Future.wait([startStationData, endStationData]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("데이터를 불러오는 중 오류가 발생했습니다."));
            } else if (!snapshot.hasData || snapshot.data!.length < 2) {
              return Center(
                child: Text("출발역 또는 도착역 정보를 찾을 수 없습니다."),
              );
            }

            final startData = snapshot.data![0] as Map<String, dynamic>;
            final endData = snapshot.data![1] as Map<String, dynamic>;

<<<<<<< HEAD
          return FutureBuilder(
            future: dijkstra(
              startData['routeInfo']['startStation'].toString(),
              endData['routeInfo']['startStation'].toString(),
            ),
            builder:
                (context, AsyncSnapshot<Map<String, dynamic>> dijkstraResult) {
              if (dijkstraResult.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (dijkstraResult.hasError) {
                return Center(child: Text("최단 경로 계산 중 오류 발생."));
              } else if (!dijkstraResult.hasData) {
                return Center(
                  child: Text("경로를 찾을 수 없습니다."),
                );
              }

              final result = dijkstraResult.data!;
              return _buildPageContent(result, startData, endData);
=======
            return FutureBuilder(
              future: dijkstra(
                startData['routeInfo']['startStation'].toString(),
                endData['routeInfo']['startStation'].toString(),
              ),
              builder: (context,
                  AsyncSnapshot<Map<String, dynamic>> dijkstraResult) {
                if (dijkstraResult.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (dijkstraResult.hasError) {
                  return Center(child: Text("최단 경로 계산 중 오류 발생."));
                } else if (!dijkstraResult.hasData) {
                  return Center(
                    child: Text("경로를 찾을 수 없습니다."),
                  );
                }

                final result = dijkstraResult.data!;
                return _buildPageContent(result, startData, endData);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.0, // 높이 조절
        color: const Color.fromARGB(204, 34, 83, 111), // 배경색 설정
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(), // Home()으로 이동
                ),
              );
>>>>>>> 738d089bc3b21deeebda6b7f07adfb3dd760f464
            },
            child: Image.asset(
              'assets/images/homeLight.png',
              width: 35,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.0, // 높이 조절
        color: const Color.fromARGB(204, 34, 83, 111), // 배경색 설정
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(), // Home()으로 이동
                ),
              );
            },
            child: Image.asset(
              'assets/images/homeLight.png',
              width: 35,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(Map<String, dynamic> result,
      Map<String, dynamic> startData, Map<String, dynamic> endData) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildButton('최소 거리 순', isMinDistanceSelected, () {
                setState(() {
                  isMinDistanceSelected = false;
                });

                // minimumDistance 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => minimumDistance(
                      startStation: widget.startStation,
                      endStation: widget.endStation,
                    ),
                  ),
                );
              }),
              SizedBox(width: 10),
              _buildButton('최소 시간 순', !isMinDistanceSelected, () {
                setState(() {
                  isMinDistanceSelected = true;
                });

                // minimumTransfer 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MinimumTransfer(
                      startStation: widget.startStation,
                      endStation: widget.endStation,
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    // 소요 시간 텍스트
                    Text(
                      "소요 시간",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    // 소요 시간 값
                    Text(
                      "${(result['duration'] / 60).floor()}분 ${(result['duration'] % 60).toInt()}초",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4C4C4C),
                      ),
                    ),
                    SizedBox(height: 5), // 항목 간의 간격

                    // 환승 정보, 비용 정보, 거리 정보는 한 줄로 배치
                    Text(
                      "환승 ${result['transferCount']}회 | 비용 ${result['cost']}원 | 거리 ${(result['distance'] / 1000).toStringAsFixed(2)}km",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          _buildTravelDetails(result['path']),
        ],
      ),
    );
  }

  Widget _buildButton(String text, bool isSelected, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff397394) : Colors.white,
          border: Border.all(color: Color(0xff397394)),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Color(0xff397394),
          ),
        ),
      ),
    );
  }

  //findway에 값을 넘겨주기 위함
  Widget _buildTravelDetails(List<Map<String, dynamic>> uiDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: uiDetails.map((detail) {
        return findWay(
          lineNumber: detail['line'].toString(),
          stationName: detail['stationName'],
          quickExit: detail['quickExit'] ?? "",
          doorSide: detail['doorSide'] ?? "",
          duration: detail['duration'] != ""
              ? "${(detail['duration'] / 60).floor()}분 ${(detail['duration'] % 60).toInt()}초"
              : "", // duration이 비어있을 경우 출력하지 않음
        );
      }).toList(),
    );
  }
}
