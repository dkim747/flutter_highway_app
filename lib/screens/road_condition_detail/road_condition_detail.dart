import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/service/bookmark_service_factory.dart';
import 'package:app1/common_model/bookmark/service/interface_bookmark_service.dart';
import 'package:app1/common_widgets/base_layout.dart';
import 'package:app1/provider/permission_controller.dart';
import 'package:app1/screens/road_condition_detail/utils/road_condition_details_utils.dart';
import 'package:app1/screens/road_condition_detail/widgets/menu_widget.dart';
import 'package:app1/screens/road_condition_detail/widgets/speedbar_with_direction_arrow_widget.dart';
import 'package:app1/screens/road_condition_detail/widgets/direction_switching_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/snackbar.dart';
import '../road_condition/model/routes.dart';
import 'model/direction.dart';
import 'model/route_info.dart';
import 'model/small_icons.dart';

class RoadConditionDetailScreen extends StatefulWidget {

  final String serviceType;

  const RoadConditionDetailScreen({
    super.key,
    required this.serviceType
  });

  @override
  State<RoadConditionDetailScreen> createState() => _RoadConditionDetailScreenState();
}

class _RoadConditionDetailScreenState extends State<RoadConditionDetailScreen> {

  late final BookmarkService bookmarkService;

  //T_TRMB_ROUTE_TRFC_CRCM01L1 테이블, cctv 테이블 조인시켜서 가져올듯? 썸네일 있으니
  List<RouteInfo> routeList = [
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '한남IC', linkKmDstne: '1.3', cctvNm: '한남IC', cctvUrl: "https://exmobile4.hscdn.com/cctv0002image/ch00000002_20250522.184100.000.jpg", spd: 38),
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '잠원IC', linkKmDstne: '1.38', cctvNm: '잠원IC', spd: 50),
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '한남IC', linkKmDstne: '1.3', cctvNm: '한남IC', cctvUrl: "https://exmobile4.hscdn.com/cctv0002image/ch00000002_20250522.184100.000.jpg", spd: 38),
    RouteInfo(routeCd: '0010', driveDrctDc: 'E', nodeCtltNm: '한남IC', linkKmDstne: '1.3', cctvNm: '한남IC', cctvUrl: "https://exmobile4.hscdn.com/cctv0002image/ch00000002_20250522.184100.000.jpg", spd: 80),
    RouteInfo(routeCd: '0010', driveDrctDc: 'S', nodeCtltNm: '한남IC', linkKmDstne: '1.3', cctvNm: '한남IC', cctvUrl: "https://exmobile4.hscdn.com/cctv0002image/ch00000002_20250522.184100.000.jpg", spd: 38),
    RouteInfo(routeCd: '0010', driveDrctDc: 'S', nodeCtltNm: '한남IC', linkKmDstne: '1.3', cctvNm: '한남IC', cctvUrl: "https://exmobile4.hscdn.com/cctv0002image/ch00000002_20250522.184100.000.jpg", spd: 80),
  ];

  String selectedDirection = Direction.e;
  IconData? selectedIcon;
  bool isFavorite = false;

  // bool get isLocationGranted =>
  //     Provider.of<PermissionController>(context, listen: false).isLocationGranted ?? false;


  @override
  void initState() {
    super.initState();

    // eventBus.on<LocationSearchEvent>().listen((event) {
    //   LocationController.getEvent();
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<PermissionController>().checkPermission();

      final route = ModalRoute.of(context)!.settings.arguments as Routes;
      final routeNo = route.routeNo;

      _checkBookmarkState(routeNo, selectedDirection);
    });

    final BookmarkServiceFactory factory = BookmarkServiceFactory();
    bookmarkService = factory.getBookmarkService(widget.serviceType);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   if (_isInit) {
  //     final route = ModalRoute.of(context)!.settings.arguments as Routes;
  //     final routeNo = route.routeNo;
  //
  //     _checkBookmarkState(routeNo, selectedDirection);
  //
  //     // Provider.of<PermissionController>(context, listen: false).checkPermission();
  //
  //     _isInit = false;
  //   }
  // }

  void _checkBookmarkState(String routeNo, String direction) async {

    final id = "route$routeNo$direction";
    final bookmark = await bookmarkService.getBookmarkById(id);
    setState(() {
      isFavorite = bookmark != null;
    });
  }

  // void showPermissionDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return Consumer<PermissionController>(
  //         builder: (context, permissionController, child) {
  //           final granted = permissionController.isLocationGranted ?? false;
  //
  //           // 권한이 이미 허용된 경우, 다이얼로그 닫기
  //           if (granted) {
  //             // showDialog는 비동기이기 때문에 다음 프레임에서 pop 실행
  //             WidgetsBinding.instance.addPostFrameCallback((_) {
  //               if (Navigator.canPop(context)) {
  //                 Navigator.of(context).pop();
  //               }
  //             });
  //             return const SizedBox.shrink(); // 빈 위젯 반환 (안정성)
  //           }
  //
  //           // 권한이 허용되지 않았을 경우 다이얼로그 표시
  //           return AlertDialog(
  //             title: const Text('위치 정보 권한 요청'),
  //             content: const Text('위치 기능을 사용하려면 권한이 필요합니다. 권한을 활성화하시겠습니까?'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // 닫기
  //                 },
  //                 child: const Text('취소'),
  //               ),
  //               TextButton(
  //                 onPressed: () async {
  //                   await permissionController.confirmLocationPermission();
  //                   // Navigator.of(context).pop(); // 다이얼로그 닫기
  //                 },
  //                 child: const Text('확인'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  void showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('위치 정보 권한 요청'),
          content: const Text('위치 기능을 사용하려면 권한이 필요합니다. 권한을 활성화하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                final permissionStatus = await Permission.location.status;

                if(permissionStatus.isDenied) {
                  await Permission.location.request();
                  print("허용 안함 한번 클릭??=============");
                } else if(permissionStatus.isPermanentlyDenied) {
                  openAppSettings();
                  print("평생 거부 클릭=============");
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void handleMenuSelected(SmallIcons selected) async {

    if (selected.icon == Icons.location_searching) {

      final permissionStatus = await Permission.location.status;

      if(permissionStatus.isGranted) {
        print("현재 권한 상태는 수락====================");
        //가까운 도로 위치 보여주는 함수 작성하면 댐

      } else if(permissionStatus.isDenied) {
        print("현재 권한 상태는 거절====================");
        //거절 상태니까 다이얼로그 표출
        showPermissionDialog(context);

      } else if(permissionStatus.isPermanentlyDenied) {
        print("현재 권한 상태는 평생거부====================");
        //평생거부더라도 일단 다이얼로그 호출 근데 그 다이얼로그를 좀 다르게 해서 여러번 눌러서 설정화면으로 이동한다고 하면 되지 않을까?
        showPermissionDialog(context);
      }
    }

    if (selected.message != null && selectedIcon == selected.icon) {
      Snackbar(text: selected.message!).showSnackbar(context);
    }

    setState(() {
      if (selected.icon != Icons.location_searching) {
        selectedIcon == selected.icon
            ? selectedIcon = null
            : selectedIcon = selected.icon;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // print("이게 바뀌나 봐보자$isLocationGranted");

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
            onSelected:
            //     (icon) {
            //   handleMenuSelected(icon);
            // },
            handleMenuSelected,


            //     (icon) {
            //   setState(() {
            //     selectedIcon == icon
            //         ? selectedIcon = null
            //         : selectedIcon = icon;
            //   });
            // },
            routeNo: routeNo,
            isFavorite: isFavorite,
            onTabFavorite: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            bookmark: Bookmark(id: id, type: "route", objectMap: route.toJson(), direction: selectedDirection),
            // type: widget.serviceType,
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

                          // Visibility(
                          //   visible: selectedIcon == Icons.location_searching,
                          //   child: PermissionWidget(),
                          // ),


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
                                Image.network(route.cctvUrl!, width: MediaQuery.of(context).size.width * 0.25, height: MediaQuery.of(context).size.height * 0.1),
                                // Image.network(route.cctvUrl!, width: 50, height: 50),
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
