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
  const RoadConditionDetailScreen({super.key});

  @override
  State<RoadConditionDetailScreen> createState() => _RoadConditionDetailScreenState();
}

class _RoadConditionDetailScreenState extends State<RoadConditionDetailScreen> {

  //T_TRMB_ROUTE_TRFC_CRCM01L1 테이블, cctv 테이블 조인시켜서 가져올듯? 썸네일 있으니
  List<RouteInfo> routeList = [
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '한남IC', linkKmDstne: '1.3', cctvNm: '한남IC', cctvUrl: "https://exmobile8.hscdn.com/cctv0640image/ch00000640_20250512.162100.000.jpg", spd: 38),
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '잠원IC', linkKmDstne: '1.38', cctvNm: '잠원IC', spd: 50),
  ];

  String selectedDirection = Direction.e;
  // int? selectedIconIndex;
  IconData? selectedIcon;
  // String roadType = "일반";

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final route =  ModalRoute.of(context)!.settings.arguments as Routes;
    final routeName = route.routeName;
    final routeNo = route.routeNo;
    final startPoint = route.startPoint;
    final endPoint = route.endPoint;

    // final filteredRouteList = routeList.where((r) =>
    //   r.driveDrctDc == selectedDirection &&
    //   r.routeCd == routeNo,
    // ).toList();


    final filteredRouteList = RoadConditionDetailsUtils.getFilteredList(routeList,
                                                                        (r) => r.driveDrctDc == selectedDirection
                                                                            && r.routeCd == routeNo
                                                                       );
    
    final filteredRouteList2 = RoadConditionDetailsUtils.getFilteredList(filteredRouteList,
                                                                          (r) => r.spd < 40
                                                                        );

    List<RouteInfo> list = filteredRouteList;

    if(selectedIcon == Icons.warning_amber) {
      list = filteredRouteList2;
    } else if(selectedIcon == Icons.directions_bus_sharp) {
      // list =
    }

    // selectedIcon != Icons.warning_amber ? filteredRouteList : filteredRouteList2;

    // final int _selectedIndex;

    String id = "route$routeNo$selectedDirection";
    print("idddddddddddddddddd===============$id");

    return BaseLayout(
      title: routeName,
      screenIndex: 1,
      child: Column(
        children: [

          DirectionSwitchingWidget(
            selectedDirection: selectedDirection,
            onDirectionChanged: (direction) {
              print("방향넘어온다------------------------- $direction");
              setState(() {
                selectedDirection = direction;
                // routeList = filteredRoute;
              });
            },
            startPoint: startPoint,
            endPoint: endPoint,
          ),

          MenuWidget(
            // selectedIndex: selectedIconIndex,
            selectedIcon: selectedIcon,
            onSelected: (icon) {
              print("넘어온 인덱스 $icon");
              print("선택된 아이콘 인덱스 $selectedIcon");
              setState(() {
                selectedIcon == icon
                    ? selectedIcon = null
                    : selectedIcon = icon;
              });
            },
            routeNo: routeNo,
            isFavorite: isFavorite,
            onTabFavorite: () {
              print("아이콘 눌림");
              // if(icon == Icons.star_border_sharp) {
              setState(() {
                isFavorite = !isFavorite;
              });
              // Snackbar
              // }
              // icon == Icons.star_border_sharp
              //     ? !isFavorite
              //     : isFavorite;
            },
            // roadType: roadType,
            favoriteObject: Favorites2<Routes>(type:id, object: route),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final route = list[index];
                return
                  // Stack(
                  // clipBehavior: Clip.none,
                  // children: [
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

                    // if(index != 0)
                    // Positioned(
                    //   top: MediaQuery.of(context).size.height * -0.007,
                    //   // left: MediaQuery.of(context).padding.left + 16,
                    //   left: MediaQuery.of(context).size.width * 0.032,
                    //   child: Transform.rotate(
                    //     angle: selectedDirection == Direction.s ? pi : 0,
                    //     child: CustomPaint(
                    //       size: Size(MediaQuery.of(context).size.width * 0.04, MediaQuery.of(context).size.width * 0.03),
                    //       painter: VArrowWidget(borderColor: Colors.black, fillColor: Colors.white),
                    //     ),
                    //   )
                    // )
                //   ],
                // );
              },
            ),
          ),
        ],
      )
    );
  }
}
