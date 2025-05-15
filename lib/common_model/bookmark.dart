import 'dart:convert';

class Bookmark {

  final String id;
  final String type;
  final Map<String, dynamic> objectMap;
  // final DateTime addedAt;

  Bookmark({
    required this.id,
    required this.type,
    required this.objectMap
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "objectMap": jsonEncode(objectMap)
    };
  }

  factory Bookmark.fromMap(Map<String, dynamic> map) {

    return Bookmark(
      id: map['id'],
      type: map['type'],
      objectMap: jsonDecode(map['objectMap'])
    );
  }
}