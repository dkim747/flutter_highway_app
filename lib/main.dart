import 'package:app1/provider/notice_controller.dart';
import 'package:app1/screens/road_condition/road_condition.dart';
import 'package:app1/screens/road_condition_detail/road_condition_detail.dart';
import 'package:app1/screens/traffic_map/traffic_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (_) => NoticeController(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '교통 앱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: (context, child) {
        return child!;
      },
      initialRoute: "/screens/routesCondition",
      onGenerateRoute: (router) {

        switch(router.name) {

          case '/screens/routesCondition':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => RoadConditionScreen(),
              transitionDuration: Duration(seconds: 0),
            );

          case '/screens/trafficMap':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => TrafficMapScreen(),
              transitionDuration: Duration(seconds: 0)
            );

          case '/screens/roadConditionDetail':
          // final routeName = router.arguments as String;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => RoadConditionDetailScreen(
                  // bookmarkRepository: BookmarkRepositoryFactory().getBookmarkRepository("default"),
                  serviceType: "default",
                ),
                settings: RouteSettings(
                  name: router.name,
                  arguments: router.arguments, // 👈 이걸 추가해야 ModalRoute.of(context)에서 받음!
                ),
                transitionDuration: Duration(seconds: 0)
            );
        }
        return null;
      },
    );
  }
}

