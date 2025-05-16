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

  @override
  Future<void> insertBookmark(Bookmark bookmark) {
    // TODO: implement insertBookmark
    throw UnimplementedError();
  }

}