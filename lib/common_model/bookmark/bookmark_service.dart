import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/repository/bookmark_repository_factory.dart';
import 'package:app1/common_model/bookmark/repository/interface_bookmark_repository.dart';

class BookmarkService {

  final BookmarkRepositoryFactory bookmarkRepositoryFactory;

  BookmarkService(this.bookmarkRepositoryFactory);  

  Future<void> addBookmark(Bookmark bookmark, String type) async {

    final BookmarkRepository bookmarkRepository = bookmarkRepositoryFactory.getBookmarkService(type);
 
    final existing = await bookmarkRepository.getBookmarkById(bookmark.id);
    if (existing == null) {
      await bookmarkRepository.insertBookmark(bookmark);
    }
  }
}