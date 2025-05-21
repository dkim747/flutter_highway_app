import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends ChangeNotifier {
  bool? _isLocationGranted;

  bool? get isLocationGranted => _isLocationGranted;

  Future<void> checkPermission() async {
    final status = await Permission.location.status;
    _isLocationGranted = status.isGranted;

    print("qweqweqweqweqweqweqweqweqweqweqwe$_isLocationGranted");
    notifyListeners();
  }

  Future<void> confirmLocationPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      print("위치 권한 허용됨");
    } else if (status.isDenied) {
      print("위치 권한 거부됨");
    } else if (status.isPermanentlyDenied) {
      print("권한이 다시 묻지 않음 상태");
      // 필요시 앱 설정 화면으로 안내
      openAppSettings();
    }

    _isLocationGranted = status.isGranted;

    print("asdasdasdasdasdasdasd$_isLocationGranted");
    notifyListeners();
  }
}
