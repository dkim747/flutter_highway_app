import 'package:flutter/material.dart';

import '../model/direction.dart';

class DirectionSwitchingWidget extends StatelessWidget {
  
  final String selectedDirection;
  final ValueChanged<String> onDirectionChanged;
  final String startPoint;
  final String endPoint;

  const DirectionSwitchingWidget({
    super.key,
    required this.selectedDirection,
    required this.onDirectionChanged,
    required this.startPoint,
    required this.endPoint
  });

  @override
  Widget build(BuildContext context) {

    final isEastSelected = selectedDirection == Direction.e;

    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: Colors.white24,
                  width: 3
              )
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: isEastSelected ? Alignment.centerLeft : Alignment.centerRight,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Color(0xFF1A2A4B),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  _buildToggleOption(
                    label: '$endPoint → $startPoint' ,
                    isSelected: isEastSelected,
                    onTap: () => onDirectionChanged(Direction.e),
                  ),
                  _buildToggleOption(
                    label: '$startPoint → $endPoint',
                    isSelected: !isEastSelected,
                    onTap: () => onDirectionChanged(Direction.s),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        // child: SizedBox(
          // height: 40,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          // ),
        ),
      ),
    );
  }
}
