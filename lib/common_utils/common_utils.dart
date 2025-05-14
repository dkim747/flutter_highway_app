import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_model/favorites2.dart';
import '../screens/road_condition/interface/jsonencodable_interface.dart';
import '../screens/road_condition/model/routes.dart';

class CommonUtils {

  // shared_preference에 객체 저장할 공통 함수. 인터페이스로 구현하였다.
  // static Future<void> saveObjectInSharedPreference(String key, JsonEncodable object) async {
  //
  //   try{
  //
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String json = jsonEncode(object.toJson2());
  //     print("공통함수 제이슨-----------$json");
  //     await preferences.setString(key, json);
  //   } catch(e) {
  //
  //     print(e);
  //   }
  // }

  //shared_preference에 객체 저장할 공통 함수. 제네릭 사용.
  static Future<void> saveObjectInPreference<T>(String key, T object, Map<String, dynamic> Function(T) toJsonFunc) async {

    try{

      final prefs = await SharedPreferences.getInstance();
      final json = jsonEncode(toJsonFunc(object));
      // print("어렵다-==---------$json");
      await prefs.setString(key, json);
    } catch(e) {

      print(e);
    }
  }

  //shared_preference에서 객체 불러올 공통 함수
  static Future<T?> loadObjectFromPreference<T>(String key, T Function(Map<String, dynamic>) fromJsonFunc) async {

    try {

      final prefs = await SharedPreferences.getInstance();

      final jsonString = prefs.getString(key);

      if (jsonString == null) {

        return null;
      }

      final jsonMap = jsonDecode(jsonString);

      return fromJsonFunc(jsonMap);

    } catch(e) {

      print(e);
      return null;
    }
  }

  static Future<void> saveObjectListInPreference<T>(String key, T object,
      Map<String, dynamic> Function(T) toJsonFunc, String Function(T) getIdFunc, T Function(Map<String, dynamic>) fromJsonFunc,) async {

    try{

      final prefs = await SharedPreferences.getInstance();

      // prefs.remove("favorite");

      final json = jsonEncode(toJsonFunc(object));

      /////////
      final objectId = getIdFunc(object);
      print("오브젝트 아이디===========$objectId");


      // List<String>? existingList = prefs.getStringList(key);

      List<String> existingList = prefs.getStringList(key) ?? [];

      print("asdasdasdasd$existingList");

      // 중복 체크: 기존 리스트에서 같은 ID가 있는지 확인


      // if(existingList != null) {

        // final existingObject = existingList.

      print("실행됌11111111111111111111");
        final exists = existingList.any((item) {
          final decoded = jsonDecode(item);
          final existingId = getIdFunc(fromJsonFunc(decoded));

          return existingId == objectId;
        });
      print("실행됌2222222222222222222222");
        if(!exists) {
          existingList.add(json);
          await prefs.setStringList(key, existingList);
          print("저장됌-=-=-=-=-=-=-=-=-=-");
        } else {
          print("이미 존재한다-----------");
        }

      // } else {
      //   List<String> newList = [];
      //
      //   newList.add(json);
      //
      //   await prefs.setStringList(key, newList);
      // }



    } catch(e) {

      print(e);
    }
  }

}