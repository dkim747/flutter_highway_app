import 'dart:convert';

import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkRepository {

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<void> insertBookmark(Bookmark bookmark) async {

  final Database db = await databaseHelper.database;

  await db.insert(
    'bookmark',
    {
      'id': bookmark.id,
      'type': bookmark.type,
      'objectMap': jsonEncode(bookmark.objectMap),
    },
    // conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// get all bookmarks
Future<List<Bookmark>> getBookmarks() async {

  final Database db = await databaseHelper.database;

  final result = await db.query('bookmark');

  return result.map((map) => Bookmark.fromMap(map)).toList();
}

Future<Bookmark?> getBookmarkById(String id) async {

  final Database db = await databaseHelper.database;

  final List<Map<String, dynamic>> result = await db.query(
    'bookmark',
    where: 'id = ?',
    whereArgs: [id]
  );

  if(result.isNotEmpty) {
    return Bookmark.fromMap(result.first);
  } else {
    return null;
  }
}

// delete
Future<void> deleteBookmark(String id) async {

  final Database db = await databaseHelper.database;
  await db.delete(
    'bookmark',
    where: 'id = ?',
    whereArgs: [id],
  );
}
}