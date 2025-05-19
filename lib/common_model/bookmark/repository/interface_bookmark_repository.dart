import 'package:app1/common_model/bookmark/bookmark.dart';

abstract class BookmarkRepository {

  String get type;

  Future<void> insertBookmark(Bookmark bookmark);

  Future<List<Bookmark>> findAllBookmarks();

  Future<Bookmark?> getBookmarkById(String id);

  Future<void> deleteBookmark(String id);
}