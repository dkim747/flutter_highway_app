import 'package:flutter/material.dart';


class RoadConditionDetailsUtils {

  static MaterialColor getContainerColor(double spd) {

    if(spd < 40) {

      return Colors.red;

    } else if(spd >= 40 && spd < 80) {

      return Colors.yellow;
    }

    return Colors.green;
  }

  static List<T> getFilteredList<T>(List<T> list, bool Function(T) condition) {

    return list.where(condition).toList();
  }

}