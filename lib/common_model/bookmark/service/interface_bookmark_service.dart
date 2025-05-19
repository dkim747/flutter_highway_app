import 'package:app1/common_model/bookmark/bookmark.dart';

abstract class BookmarkService {

  // String get type;
  
  Future<void> addBookmark(Bookmark bookmark);

  Future<Bookmark?> getBookmarkById(String id);

  Future<void> deleteBookmark(String id);
}