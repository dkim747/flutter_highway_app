import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/repository/bookmark_repository.dart';
import 'package:app1/common_model/bookmark/service/interface_bookmark_service.dart';

class DefaultBookmarkService extends BookmarkService {

  final DefaultBookmarkRepository bookmarkRepository;
  
  DefaultBookmarkService({
    required this.bookmarkRepository
  });

  @override
  Future<void> addBookmark(Bookmark bookmark) async {
    
    final Bookmark? existing = await bookmarkRepository.findBookmarkById(bookmark.id);

    if(existing == null) {

      await bookmarkRepository.insertBookmark(bookmark);
    }    
  }

  @override
  Future<void> deleteBookmark(String id) async {

    final Bookmark? existing = await bookmarkRepository.findBookmarkById(id);

    if(existing != null) {

      await bookmarkRepository.deleteBookmark(id);
    }    
  }

  @override
  Future<Bookmark?> getBookmarkById(String id) async {

    Bookmark? bookmark = await bookmarkRepository.findBookmarkById(id);

    return bookmark;
  }
  
  // @override
  // String get type => "default";
}