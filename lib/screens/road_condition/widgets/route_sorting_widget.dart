import 'package:flutter/material.dart';

enum SortType {nameAsc, nameDesc, numberAsc, numberDesc}

class RouteSortingWidget extends StatelessWidget {

  final SortType selectedType;
  final ValueChanged<SortType> onSelectedType;

  const RouteSortingWidget({
    super.key,
    required this.selectedType,
    required this.onSelectedType
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoiceChip(
          label: const Text("노선명↑"),
          selected: selectedType == SortType.nameAsc,
          onSelected: (_) => onSelectedType(SortType.nameAsc),
        ),
        SizedBox(width: 2),
        ChoiceChip(
          label: const Text("노선명↓"),
          selected: selectedType == SortType.nameDesc,
          onSelected: (_) => onSelectedType(SortType.nameDesc),
        ),
        SizedBox(width: 2),
        ChoiceChip(
          label: const Text("노선번호↑"),
          selected: selectedType == SortType.numberAsc,
          onSelected: (_) => onSelectedType(SortType.numberAsc),
        ),
        SizedBox(width: 2),
        ChoiceChip(
          label: const Text("노선번호↓"),
          selected: selectedType == SortType.numberDesc,
          onSelected: (_) => onSelectedType(SortType.numberDesc),
        )
      ],
    );
  }
}
