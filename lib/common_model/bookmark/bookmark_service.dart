import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/bookmark_repository.dart';

class BookmarkService {

  final BookmarkRepository bookmarkRepository;

  BookmarkService(this.bookmarkRepository);  

  Future<void> addBookmark(Bookmark bookmark) async {
    // 중복 체크: 이미 존재하면 추가하지 않음
    final existing = await bookmarkRepository.getBookmarkById(bookmark.id);
    if (existing == null) {
      await bookmarkRepository.insertBookmark(bookmark);
    }
  }
}