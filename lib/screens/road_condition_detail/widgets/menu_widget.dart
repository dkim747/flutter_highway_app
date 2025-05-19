import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/bookmark_service.dart';
import 'package:app1/common_model/bookmark/repository/bookmark_repository_factory.dart';
import 'package:app1/common_model/favorites2.dart';
import 'package:app1/common_utils/common_utils.dart';
import 'package:app1/screens/road_condition_detail/widgets/road_type_widget.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/snackbar.dart';
import '../../road_condition/model/routes.dart';
import '../model/small_icons.dart';

class MenuWidget extends StatelessWidget {

  // final int? selectedIndex;
  // final ValueChanged<int> onSelected;

  final String routeNo;

  final IconData? selectedIcon;
  final ValueChanged<IconData> onSelected;

  // final String roadType;
  final bool isFavorite;
  // final ValueChanged<IconData> onTabFavorite;
  final VoidCallback onTabFavorite;
  // final Favorites2 favoriteObject;
  final Bookmark bookmark;
  final String type;

  const MenuWidget({
    super.key,
    // this.selectedIndex,
    required this.onSelected,
    required this.routeNo,
    required this.selectedIcon,
    // required this.roadType
    required this.isFavorite,
    required this.onTabFavorite,
    // required this.favoriteObject
    required this.bookmark,
    required this.type
  });

  // final iconList = [
  //   Icons.location_searching,
  //   Icons.sunny,
  //   Icons.local_gas_station,
  //   Icons.directions_bus_sharp,
  //   Icons.alt_route,
  //   Icons.warning_amber,
  //   Icons.star_border_sharp
  // ];

  // final List<Map<String, dynamic>> iconMap = [
  //   {'icon': Icons.location_searching, "text": '위치 정보를 표시합니다.'},
  //   {'icon': Icons.sunny, 'text': '날씨 정보를 표시합니다.'},
  //   {'icon': Icons.local_gas_station, 'text': '주유소 정보를 표시합니다.'},
  //   {'icon': Icons.directions_bus_sharp, 'text': '버스 정보를 표시합니다.'},
  //   {}
  // ];

  final List<SmallIcons> iconList = const [
    SmallIcons(icon: Icons.location_searching, message: '위치 정보를 표시합니다'),
    SmallIcons(icon: Icons.sunny, message: '날씨 정보를 표시합니다'),
    SmallIcons(icon: Icons.local_gas_station),
    SmallIcons(icon: Icons.directions_bus_sharp, message: '버스전용차로 정보를 표출합니다'),
    SmallIcons(icon: Icons.alt_route, message: '우회도로를 표출합니다'),
    SmallIcons(icon: Icons.warning_amber, message: '정체구간 정보를 표출합니다'),
    // SmallIcons(icon: Icons.star_border_sharp, message: '즐겨찾기를 등록 하였습니다'),
  ];

  @override
  Widget build(BuildContext context) {

    // final List<SmallIcons> iconList = [
    //   SmallIcons(icon: Icons.location_searching, message: '위치 정보를 표시합니다'),
    //   SmallIcons(icon: Icons.sunny, message: '날씨 정보를 표시합니다'),
    //   SmallIcons(icon: Icons.local_gas_station),
    //   if(routeNo == '0010')
    //     SmallIcons(icon: Icons.directions_bus_sharp, message: '버스전용차로 정보를 표출합니다'),
    //   SmallIcons(icon: Icons.alt_route, message: '우회도로를 표출합니다'),
    //   SmallIcons(icon: Icons.warning_amber, message: '정체구간 정보를 표출합니다'),
    //   SmallIcons(icon: Icons.star_border_sharp, message: '즐겨찾기를 등록 하였습니다'),
    // ];

    final icons = iconList.where((r) =>
      !(r.icon == Icons.directions_bus_sharp &&
        routeNo != '0010')
    ).toList();

    // final icons = iconList.where((r) =>
    //   routeNo == '0010' ||
    //   r.icon != Icons.directions_bus_sharp
    // ).toList();

    return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        color: Colors.grey[800],
        child: Row(
          children: [

            RoadTypeWidget(
              isSelected: selectedIcon == Icons.directions_bus_sharp,
                // selectedIcon: selectedIcon!,
              roadType: "버스"
            ),

            RoadTypeWidget(
                isSelected: selectedIcon == Icons.alt_route,
                // selectedIcon: selectedIcon!,
                roadType: "우회"
            ),

            // Visibility(
            //   visible: selectedIcon == Icons.alt_route,
            //   child: Container(
            //     padding: EdgeInsets.only(
            //         left:
            //         // selectedIcon == Icons.directions_bus_sharp || selectedIcon == Icons.alt_route ?
            //         // MediaQuery.of(context).size.width * 0.11:
            //         MediaQuery.of(context).size.width * 0.02
            //     ),
            //     child: Text(
            //       // roadType,
            //       "우회",
            //       style: TextStyle(
            //           color: Colors.white
            //       ),
            //     ),
            //   ),
            // ),

            Container(
              padding: EdgeInsets.only(
                left: selectedIcon == Icons.directions_bus_sharp || selectedIcon == Icons.alt_route ?
                MediaQuery.of(context).size.width * 0.025 :
                MediaQuery.of(context).size.width * 0.02
              ),
              child: Text(
                // roadType,
                "일반",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),

            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.25,
            // ),

            Spacer(),

            ...List.generate(icons.length, (index) {

              final currentIcon = icons[index];
              // final isSelected = selectedIndex == index;

              final isSelected = selectedIcon == currentIcon.icon;

              return Row(
                children: [
                  _buildMenuIcons(
                    icon: currentIcon.icon,
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                    isSelected: isSelected,
                    onTap: () {
                      onSelected(currentIcon.icon);
                      if(currentIcon.message != null && selectedIcon != currentIcon.icon) {
                        Snackbar(
                            text: currentIcon.message!
                        ).showSnackbar(context);
                      }
                      // onSelected(currentIcon.icon);
                    }
                  ),
                  // if(index != icons.length - 1)
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
                ],
              );
            }),

            GestureDetector(
              child: Container(
                color: isFavorite ? Colors.blue : Colors.white,
                width: MediaQuery.of(context).size.width * 0.07,
                height: MediaQuery.of(context).size.width * 0.07,
                child: Icon(
                  Icons.star_border_sharp,
                  color: isFavorite ? Colors.white : Colors.grey,
                ),
              ),
              onTap: () {
                onTabFavorite();
                if(!isFavorite) {
                  Snackbar(
                    text: "즐겨찾기 등록"
                  ).showSnackbar(context);
                  // CommonUtils.saveObjectInPreference<Favorites2>("favorite", favoriteObject, (r) => r.toJson((s) => s.toJson()));

                // CommonUtils.loadObjectFromPreference<Favorites2>("favorite", (r) => Favorites2.fromJson(r, (t) => Routes.fromJson(t)))
                //   .then((r) => print(r?.object));

                  // CommonUtils.saveObjectListInPreference<Favorites2>("favorite", favoriteObject, (r) => r.toJson((s) => s.toJson()), (r) => r.type,(json) {
                  //   final type = json['type'];

                  //   if (type.startsWith("route")) {
                  //     return Favorites2.fromJson(json, (obj) => Routes.fromJson(obj));
                  //   } else if (type.startsWith("cctv")) {
                  //     // return Favorites2.fromJson(json, (obj) => CCTV.fromJson(obj));
                  //   } else if (type.startsWith("news")) {
                  //     // return Favorites2.fromJson(json, (obj) => News.fromJson(obj));
                  //   }

                  //   throw UnsupportedError("Unknown type: $type");
                  // }, );

                  // List<Favorites2> list = [];
                  // list.add(favoriteObject);

                  print("저장시작----------------");
                  final BookmarkRepositoryFactory bookmarkRepositoryFactory = BookmarkRepositoryFactory();
                  final BookmarkService bookmarkService = BookmarkService(bookmarkRepositoryFactory);
                  bookmarkService.addBookmark(bookmark, type);

                } else {
                  Snackbar(
                      text: "즐겨찾기 해제"
                  ).showSnackbar(context);
                }
              },
            ),

            SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
          ],
        )
    );
  }

  Widget _buildMenuIcons({
    required IconData icon,
    required double width,
    required double height,
    required bool isSelected,
    required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        color: isSelected ? Colors.blue : Colors.white,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
