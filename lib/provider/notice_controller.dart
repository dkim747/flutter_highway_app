import 'dart:async';
import 'package:flutter/cupertino.dart';

class NoticeController extends ChangeNotifier {

  int _index = 0;
  Timer? _timer;
  bool _isTimer = false;
  bool isVisible = true;

  int get index => _index;

  void startAutoSlide(int listLength) {

    if(_isTimer) return;

    _isTimer = true;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _index = (_index + 1) % listLength;
      notifyListeners();
    });
  }

  void stopAutoSlide() {

    _timer?.cancel();

    _timer = null;
  }

  void hideBanner() {
    isVisible = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // void next(int length) {
  //   _index = (_index + 1) % length;
  //   notifyListeners();
  // }
}