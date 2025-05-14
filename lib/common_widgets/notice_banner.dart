import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notice_controller.dart';

class NoticeBanner extends StatefulWidget {
  const NoticeBanner({super.key});

  @override
  State<NoticeBanner> createState() => _NoticeBannerState();
}

class _NoticeBannerState extends State<NoticeBanner> {

  final noticeList = [
    "고속도로 운전 중 스마트 기기 어쩌구",
    "콜센터 교통안전 어쩌구",
    "청송휴게소 화재",
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoticeController>().startAutoSlide(noticeList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeController> (
      builder: (context, controller, _) {
        return Visibility(
          visible: controller.isVisible,
          child:  Container(
            color: Colors.indigoAccent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.announcement, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {

                      final slide = Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation);

                      return SlideTransition(
                        position: slide,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      noticeList[controller.index],
                      key: ValueKey(controller.index),
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ),
                IconButton(
                    onPressed: () {
                      controller.stopAutoSlide();
                      controller.hideBanner();
                    },
                    icon: const Icon(Icons.close, color: Colors.white,)
                )
              ],
            ),
          ),
        );
      },
    );
  }
}