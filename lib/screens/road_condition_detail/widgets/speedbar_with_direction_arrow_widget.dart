import 'dart:math';

import 'package:app1/screens/road_condition_detail/widgets/v_arrow_widget.dart';
import 'package:flutter/material.dart';

import '../model/direction.dart';
import '../utils/road_condition_details_utils.dart';

class SpeedbarWithDirectionArrowWidget extends StatelessWidget {

  final double speed;
  final int index;
  final String selectedDirection;

  const SpeedbarWithDirectionArrowWidget({
    super.key,
    required this.speed,
    required this.index,
    required this.selectedDirection
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.04,
          color: RoadConditionDetailsUtils.getContainerColor(speed),
        ),

        if(index != 0)
          Positioned(
              top: MediaQuery.of(context).size.height * -0.007,
              child: Transform.rotate(
                angle: selectedDirection == Direction.s ? pi : 0,
                child:  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width * 0.04, MediaQuery.of(context).size.width * 0.03),
                    painter: VArrowWidget(borderColor: Colors.black, fillColor: Colors.white)
                ),
              )
          )
      ],
    );
  }
}
