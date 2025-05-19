import 'dart:convert';

import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/repository/interface_bookmark_repository.dart';
import 'package:app1/common_model/bookmark/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TestBookmarkRepository extends BookmarkRepository{

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<void> deleteBookmark(String id) {
    // TODO: implement deleteBookmark
    throw UnimplementedError();
  }

  @override
  Future<List<Bookmark>> findAllBookmarks() {
    // TODO: implement findAllBookmarks
    throw UnimplementedError();
  }

  @override
  Future<Bookmark?> findBookmarkById(String id) async {
    final Database db = await databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      'bookmark_test',
      where: 'id = ?',
      whereArgs: [id]
    );

    if(result.isNotEmpty) {
      return Bookmark.fromMap(result.first);
    } else {
      return null;
    }
  }

  @override
  Future<void> insertBookmark(Bookmark bookmark) async {
    final Database db = await databaseHelper.database;

    await db.insert(
      'bookmark_test',
      {
        'id': bookmark.id,
        'type': bookmark.type,
        'objectMap': jsonEncode(bookmark.objectMap),
      },
    );
  }
  
  @override
  String get type => "test";

}