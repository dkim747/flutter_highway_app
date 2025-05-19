import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/bookmark_service.dart';
import 'package:app1/common_model/bookmark/repository/bookmark_repository.dart';
import 'package:app1/common_model/bookmark/repository/bookmark_repository_factory.dart';
import 'package:app1/common_model/bookmark/repository/interface_bookmark_repository.dart';
import 'package:app1/common_model/favorites2.dart';
import 'package:app1/common_widgets/base_layout.dart';
import 'package:app1/screens/road_condition_detail/utils/road_condition_details_utils.dart';
import 'package:app1/screens/road_condition_detail/widgets/menu_widget.dart';
import 'package:app1/screens/road_condition_detail/widgets/speedbar_with_direction_arrow_widget.dart';
import 'package:app1/screens/road_condition_detail/widgets/direction_switching_widget.dart';
import 'package:flutter/material.dart';
import '../road_condition/model/routes.dart';
import 'model/direction.dart';
import 'model/route_info.dart';

class RoadConditionDetailScreen extends StatefulWidget {

  final String repoType;

  const RoadConditionDetailScreen({
    super.key,
    required this.repoType
  });

  @override
  State<RoadConditionDetailScreen> createState() => _RoadConditionDetailScreenState();
}

class _RoadConditionDetailScreenState extends State<RoadConditionDetailScreen> {

  late final BookmarkService bookmarkService;

  //T_TRMB_ROUTE_TRFC_CRCM01L1 테이블, cctv 테이블 조인시켜서 가져올듯? 썸네일 있으니
  List<RouteInfo> routeList = [
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '한남IC', linkKmDstne: '1.3', cctvNm: '한남IC', cctvUrl: "https://exmobile8.hscdn.com/cctv0640image/ch00000640_20250512.162100.000.jpg", spd: 38),
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '잠원IC', linkKmDstne: '1.38', cctvNm: '잠원IC', spd: 50),
  ];

  String selectedDirection = Direction.e;
  IconData? selectedIcon;

  bool isFavorite = false;

  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    final BookmarkRepositoryFactory factory = BookmarkRepositoryFactory();
    bookmarkService = BookmarkService(factory);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final route = ModalRoute.of(context)!.settings.arguments as Routes;
      final routeNo = route.routeNo;

      _checkBookmarkState(routeNo, selectedDirection);

      _isInit = false;
    }
  }

  void _checkBookmarkState(String routeNo, String direction) async {

    final id = "route$routeNo$direction";
    final bookmark = await bookmarkService.getBookmarkById(id, widget.repoType);
    setState(() {
      isFavorite = bookmark != null;
    });
  }

  @override
  Widget build(BuildContext context) {

    final Routes route =  ModalRoute.of(context)!.settings.arguments as Routes;
    final String routeName = route.routeName;
    final String routeNo = route.routeNo;
    final String startPoint = route.startPoint;
    final String endPoint = route.endPoint;

    // final filteredRouteList = routeList.where((r) =>
    //   r.driveDrctDc == selectedDirection &&
    //   r.routeCd == routeNo,
    // ).toList();

    //굳이 이렇게 할 필요 없지만 제네릭으로 함수 만들어 보려고 함수 만듬
    final List<RouteInfo> filteredRouteList = RoadConditionDetailsUtils.getFilteredList(routeList,
                                                                        (r) => r.driveDrctDc == selectedDirection
                                                                            && r.routeCd == routeNo
                                                                       );
    
    final List<RouteInfo> filteredRouteList2 = RoadConditionDetailsUtils.getFilteredList(filteredRouteList,
                                                                          (r) => r.spd < 40
                                                                        );

    List<RouteInfo> list = filteredRouteList;

    if(selectedIcon == Icons.warning_amber) {
      list = filteredRouteList2;
    } else if(selectedIcon == Icons.directions_bus_sharp) {

    }

    final String id = "route$routeNo$selectedDirection";

    return BaseLayout(
      title: routeName,
      screenIndex: 1,
      child: Column(
        children: [

          DirectionSwitchingWidget(
            selectedDirection: selectedDirection,
            onDirectionChanged: (direction) {

              setState(() {
                selectedDirection = direction;
                // routeList = filteredRoute;
              });
              _checkBookmarkState(route.routeNo, direction);
            },
            startPoint: startPoint,
            endPoint: endPoint,
          ),

          MenuWidget(
            // selectedIndex: selectedIconIndex,
            selectedIcon: selectedIcon,
            onSelected: (icon) {
              setState(() {
                selectedIcon == icon
                    ? selectedIcon = null
                    : selectedIcon = icon;
              });
            },
            routeNo: routeNo,
            isFavorite: isFavorite,
            onTabFavorite: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },

            bookmark: Bookmark(id: id, type: "route", objectMap: route.toJson(), direction: selectedDirection),
            type: widget.repoType,
            bookmarkService: bookmarkService,
          ),

          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final route = list[index];
                return

                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1),
                          )
                      ),
                      height: MediaQuery.of(context).size.height * 0.09,
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.015),
                      child: Row(

                        children: [

                          Visibility(
                            visible: selectedIcon == Icons.directions_bus_sharp,
                            child: Row(
                              children: [
                                SpeedbarWithDirectionArrowWidget(
                                  speed: route.spd,
                                  index: index,
                                  selectedDirection: selectedDirection
                                ),
                                SizedBox(width: MediaQuery.of(context).size.height * 0.02,),
                              ],
                            )
                          ),

                          Visibility(
                            visible: selectedIcon == Icons.alt_route,
                            child: Row(
                              children: [
                                SpeedbarWithDirectionArrowWidget(
                                  speed: route.spd,
                                  index: index,
                                  selectedDirection: selectedDirection
                                ),
                                SizedBox(width: MediaQuery.of(context).size.height * 0.02,),
                              ],
                            )
                          ),

                          SpeedbarWithDirectionArrowWidget(
                              speed: route.spd,
                              index: index,
                              selectedDirection: selectedDirection
                          ),

                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),

                          // Expanded(
                          //   child:
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(height: 20, ),
                                Text('${route.nodeCtltNm} (${route.linkKmDstne}km)'),
                                Text('${route.spd}km/h', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),

                          // ),

                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),

                          Visibility(
                            visible: selectedIcon == Icons.sunny,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                              child: Icon(Icons.sunny),
                            ),
                          ),


                          Spacer(),

                          if (route.cctvNm != null && route.cctvUrl != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(route.cctvNm!, style: TextStyle(fontSize: 14)),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                // Image.network(route.cctvUrl!, width: MediaQuery.of(context).size.width * 0.25, height: MediaQuery.of(context).size.height * 0.1),
                                // Image.network(route.cctvUrl!, width: 100, height: 100),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        ],
      )
    );
  }
}
