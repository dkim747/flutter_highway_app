import 'package:flutter/material.dart';
import '../../common_widgets/base_layout.dart';

class TrafficMapScreen extends StatefulWidget {
  const TrafficMapScreen({super.key});

  @override
  State<TrafficMapScreen> createState() => _TrafficMapState();
}

class _TrafficMapState extends State<TrafficMapScreen> {

  @override
  Widget build(BuildContext context) {

    return BaseLayout(
        title: "교통지도",
        child: Container(color: Colors.red,),
        screenIndex: 0
    );
  }
}
