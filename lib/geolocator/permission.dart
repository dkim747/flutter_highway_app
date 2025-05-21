import 'package:geolocator/geolocator.dart';

class GeolocatorUtils {

  static Future<void> checkLocationPermission() async {
    // 위치 서비스가 켜져 있는지 확인
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // 위치 서비스가 꺼져 있음
      return Future.error('위치 서비스가 비활성화되어 있습니다.');
    }

    // 권한 상태 확인
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // 권한 요청
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // 권한 거부됨
        return Future.error('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 설정에서 직접 권한을 허용해야 함
      return Future.error('위치 권한이 영구적으로 거부되었습니다.');
    }

  }
}


