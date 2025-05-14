import 'package:flutter/material.dart';
import '../../common_utils/common_utils.dart';
import '../../common_widgets/base_layout.dart';
import 'model/routes.dart';
import 'utils/road_condition_utils.dart';
import 'widgets/route_sorting_widget.dart';
import 'widgets/search_widget.dart';

class RoadConditionScreen extends StatefulWidget {
  const RoadConditionScreen({super.key});

  @override
  State<RoadConditionScreen> createState() => _RoadConditionState();
}

class _RoadConditionState extends State<RoadConditionScreen> {

  //db에서 받아올 리스트. 지금은 그냥 예시로
  List<Routes> routeInfo = [
    Routes(routeName: "경부선", routeNo: "0010", startPoint: "부산", endPoint: "서울"),
    Routes(routeName: "호남선", routeNo: "0070", startPoint: "호남시작", endPoint: "호남끝"),
    Routes(routeName: "서울외곽선", routeNo: "1000", startPoint: "서울외곽시작", endPoint: "서울외곽끝"),
    Routes(routeName: "경인선", routeNo: "0100", startPoint: "경인시작", endPoint: "경인끝"),
  ];

  SortType selectedSort = SortType.nameAsc;
  List<Routes> searchedRouteInfo = [];

  final TextEditingController _controller = TextEditingController();

  Routes? _lastTappedRoute;

  @override
  void initState() {
    super.initState();
    // RoadConditionUtils.loadLastTappedRoute().then((route) {
    //   setState(() {
    //     _lastTappedRoute = route;
    //     searchedRouteInfo = List.from(routeInfo);
    //   });
    // });
    CommonUtils.loadObjectFromPreference('lastTappedRoute', (json) => Routes.fromJson(json))
        .then((route) {
          setState(() {
            _lastTappedRoute = route;
            searchedRouteInfo = List.from(routeInfo);
          });
    });
    // searchedRouteInfo = List.from(routeInfo);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // List<Routes> displayRouteInfo = [];
    // if(_lastTappedRoute != null) {
    //   displayRouteInfo.add(_lastTappedRoute!);
    // }
    // displayRouteInfo.addAll(searchedRouteInfo);

    return BaseLayout(
      title: "노선상황",
      screenIndex: 1,
      child: Column(
        children: [

          SearchWidget(
            search: (keyword) {
              setState(() {
                searchedRouteInfo = RoadConditionUtils.search(routeInfo, keyword)!;
              });
            },
            controller: _controller,
          ),

          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 2)
              )
            ),
            child: RouteSortingWidget(
                selectedType: selectedSort,
                onSelectedType: (sortType) {
                  setState(() {
                    selectedSort = sortType;
                    routeInfo = RoadConditionUtils.sort(routeInfo, sortType);
                    searchedRouteInfo = RoadConditionUtils.search(routeInfo, _controller.text)!;
                  });
                }
            ),
          ),

          if(_lastTappedRoute != null)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                color: Colors.yellow.shade100
              ),
              child: ListTile(
                leading: RoadConditionUtils.getRouteIconWithNumberInStack(_lastTappedRoute!.routeNo),
                title: Row(
                  children: [
                    Chip(
                      label: Text(
                        "최근",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    Text(_lastTappedRoute!.routeName)
                  ],
                ),
              ),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: searchedRouteInfo.length,
              itemBuilder: (context, index) {
                final route = searchedRouteInfo[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _lastTappedRoute = route;
                    });
                    // RoadConditionUtils.saveLastTappedRoute(route);
                    // CommonUtils.saveObjectInSharedPreference('last', route);
                    CommonUtils.saveObjectInPreference('lastTappedRoute', route, (r) => r.toJson());
                    // Navigator.pushNamed(context, '/screens/roadConditionDetail', arguments: route.routeName);
                    Navigator.pushNamed(context, '/screens/roadConditionDetail', arguments: route);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => RoadConditionDetailScreen(routeName: route.routeName)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                        )
                    ),
                    child: ListTile(
                      leading: RoadConditionUtils.getRouteIconWithNumberInStack(route.routeNo),
                      title: Text(route.routeName),
                    ),
                  ),
                );
              },
            )
          )
        ],
      )
    );
  }
}
