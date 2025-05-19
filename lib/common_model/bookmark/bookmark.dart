import 'dart:convert';

class Bookmark {

  final String id;
  final String type;
  final Map<String, dynamic> objectMap;
  final String direction;
  // final DateTime addedAt;

  Bookmark({
    required this.id,
    required this.type,
    required this.objectMap,
    required this.direction
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "objectMap": jsonEncode(objectMap),
      "direction": direction
    };
  }

  // factory Bookmark.fromMap(Map<String, dynamic> map) {
  //
  //   print("📦 Bookmark.fromMap input: $map");
  //
  //   return Bookmark(
  //     id: map['id'],
  //     type: map['type'],
  //     objectMap: jsonDecode(map['objectMap']),
  //     direction: map['direction']
  //   );
  // }

  factory Bookmark.fromMap(Map<String, dynamic> map) {

    final rawObjectMap = map['objectMap'];
    final decodedObjectMap = rawObjectMap != null ? jsonDecode(rawObjectMap) : {};

    return Bookmark(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      objectMap: decodedObjectMap,
      direction: map['direction'] ?? '',
    );
  }
}