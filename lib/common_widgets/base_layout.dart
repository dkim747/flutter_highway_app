import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';
import 'notice_banner.dart';

class BaseLayout extends StatelessWidget {

  final String title;
  final int screenIndex;
  final Widget child;


  const BaseLayout({
    super.key,
    required this.title,
    required this.screenIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,

      ),
      body: Column(
        children: [
          const NoticeBanner(),
          Expanded(child: child)
        ],
      ),
      bottomNavigationBar:CustomBottomNavigationBar(currentIndex: screenIndex),
    );
  }
}
