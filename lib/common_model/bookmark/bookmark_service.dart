import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/repository/interface_bookmark_repository.dart';

class BookmarkService {

  final BookmarkRepository bookmarkRepository;

  BookmarkService(this.bookmarkRepository);  

  Future<void> addBookmark(Bookmark bookmark) async {
 
    final existing = await bookmarkRepository.getBookmarkById(bookmark.id);
    if (existing == null) {
      await bookmarkRepository.insertBookmark(bookmark);
    }
  }
}