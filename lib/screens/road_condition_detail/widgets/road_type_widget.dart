import 'package:flutter/material.dart';

class RoadTypeWidget extends StatelessWidget {

  // final IconData selectedIcon;
  final String roadType;
  final bool isSelected;

  const RoadTypeWidget({
    super.key,
    // required this.selectedIcon,
    required this.roadType,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isSelected,
      child: Container(
        padding: EdgeInsets.only(
            left:
            // selectedIcon == Icons.directions_bus_sharp || selectedIcon == Icons.alt_route ?
            // MediaQuery.of(context).size.width * 0.11:
            MediaQuery.of(context).size.width * 0.02
        ),
        child: Text(
          roadType,
          // "우회",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
