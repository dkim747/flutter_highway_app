import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final int currentIndex;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map_rounded),
          label: "교통지도"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.router),
            label: "노선상황",
        )
      ],
      onTap: (index) {
        switch(index) {

          case 0:
            Navigator.pushReplacementNamed(context, '/screens/trafficMap');
            break;

          case 1:
            Navigator.pushReplacementNamed(context, '/screens/routesCondition');
            break;
        }
      },
    );
  }
}
