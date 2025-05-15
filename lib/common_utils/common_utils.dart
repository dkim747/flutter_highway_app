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

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String jsonObject = jsonEncode(toJsonFunc(object));

      await prefs.setString(key, jsonObject);

    } catch(e) {

      print(e);
    }

  }

  //shared_preference에서 객체 불러올 공통 함수
  static Future<T?> loadObjectFromPreference<T>(String key, T Function(Map<String, dynamic>) fromJsonFunc) async {

    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? jsonString = prefs.getString(key);

      if (jsonString == null) {

        return null;
      }

      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      return fromJsonFunc(jsonMap);

    } catch(e) {

      print(e);

      return null;
    }

  }

  static Future<void> saveObjectListInPreference<T>(String key, T object,
      Map<String, dynamic> Function(T) toJsonFunc, String Function(T) getIdFunc, T Function(Map<String, dynamic>) fromJsonFunc,) async {

    try{

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // prefs.remove("favorite");

      final String json = jsonEncode(toJsonFunc(object));

      /////////
      final String objectId = getIdFunc(object);

      // List<String>? existingList = prefs.getStringList(key);

      List<String> existingList = prefs.getStringList(key) ?? [];

      // 중복 체크: 기존 리스트에서 같은 ID가 있는지 확인

      // if(existingList != null) {

        // final existingObject = existingList.

      final exists = existingList.any((item) {
        print("아이템====================$item");
        //여기에서 jsonDecode를 해야하는 이유? 그냥 바로 item.type 이런식으로
        final decoded = jsonDecode(item);
        final existingId = getIdFunc(fromJsonFunc(decoded));

        return existingId == objectId;
      });

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