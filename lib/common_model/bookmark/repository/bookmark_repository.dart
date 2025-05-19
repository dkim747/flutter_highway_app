import 'dart:convert';
import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/repository/interface_bookmark_repository.dart';
import 'package:app1/common_model/bookmark/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DefaultBookmarkRepository extends BookmarkRepository{

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  
  @override
  Future<void> deleteBookmark (String id) async {
    
    final Database db = await databaseHelper.database;
    
    await db.delete(
      'bookmark',
      where: 'id = ?',
      whereArgs: [id],
    );    
  }
  
  @override
  Future<List<Bookmark>> findAllBookmarks() async {
    final Database db = await databaseHelper.database;

    final result = await db.query('bookmark');

    return result.map((map) => Bookmark.fromMap(map)).toList();

  }
  
  @override
  Future<Bookmark?> findBookmarkById(String id) async {
    
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
  
  @override
  Future<void> insertBookmark(Bookmark bookmark) async {
    
    final Database db = await databaseHelper.database;

    await db.insert(
      'bookmark',
      {
        'id': bookmark.id,
        'type': bookmark.type,
        'objectMap': jsonEncode(bookmark.objectMap),
      },
    );
  }
  
  @override
  String get type => "default";  
}