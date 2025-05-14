import 'package:flutter/material.dart';
import '../model/routes.dart';
import '../widgets/route_sorting_widget.dart';

class RoadConditionUtils {

  //정렬로직
  static List<Routes> sort(List<Routes> list, SortType type) {

    final newList = [...list];

    switch (type) {

      case SortType.nameAsc:

        newList.sort((a, b) => a.routeName.compareTo(b.routeName));

        break;

      case SortType.nameDesc:

        newList.sort((a, b) => b.routeName.compareTo(a.routeName));

        break;

      case SortType.numberAsc:

        newList.sort((a, b) => a.routeNo.compareTo(b.routeNo));

        break;

      case SortType.numberDesc:

        newList.sort((a, b) => b.routeNo.compareTo(a.routeNo));

        break;
    }
    return newList;
  }

  //검색로직
  static List<Routes>? search(List<Routes> routes, String query) {

    try{

      if(query.isEmpty) {
        return routes;
      }

      return routes.where((route) =>
          route.routeName.contains(query) ||
          route.routeNo.contains(query)
      ).toList();

    } catch(e) {
      print(e);
      return null;
    }
  }

  //아이콘 만드는 로직.
  //todo: png로 변경하여 숫자 넣어 표출
  static Widget getRouteIconWithNumberInStack(String routeNo) {
    return Stack(
      clipBehavior: Clip.none, // 아이콘이 잘리지 않도록
      children: [
        Icon(
          Icons.directions_car, // 기본 아이콘
          size: 50, // 아이콘 크기
          color: Colors.blue, // 아이콘 색상
        ),
        Positioned(
          top: 5, // 숫자 위치 조정 (위로 5 픽셀)
          right: 5, // 숫자 위치 조정 (오른쪽으로 5 픽셀)
          child: CircleAvatar(
            backgroundColor: Colors.red, // 원형 배경색
            radius: 15, // 원의 크기
            child: Text(
              routeNo, // 숫자 (예: '101')
              style: TextStyle(
                fontSize: 12,
                color: Colors.white, // 숫자 색상
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //shared_preference에 최근 탭한 노선 저장
  //todo: 공통함수로 작성해보기. Object 타입으로 받아서.. 일단은 load 하는거 부터 해결

  // static Future<void> saveLastTappedRoute(Routes route) async {
  //
  //   try {
  //
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String routeJson = jsonEncode(route.toJson());
  //     await preferences.setString('lastTappedRoute', routeJson);
  //   } catch(e) {
  //
  //     print(e);
  //   }
  // }
  //

  //shared_preference에서 최근 노선 불러오기
  // static Future<Routes?> loadLastTappedRoute() async {
  //
  //     try {
  //
  //       SharedPreferences preferences = await SharedPreferences.getInstance();
  //       String? lastRoute = preferences.getString('lastTappedRoute');
  //
  //       if(lastRoute != null) {
  //
  //         Map<String, dynamic> routeMap = jsonDecode(lastRoute);
  //
  //         return Routes.fromJson(routeMap);
  //       }
  //
  //     } catch(e) {
  //       print(e);
  //       return null;
  //     }
  //
  //     return null;
  // }

}

