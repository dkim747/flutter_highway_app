import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/repository/test_bookmark_repository.dart';
import 'package:app1/common_model/bookmark/service/interface_bookmark_service.dart';

class TestBookmarkService extends BookmarkService {

  final TestBookmarkRepository bookmarkRepository;

  TestBookmarkService({
    required this.bookmarkRepository
  });

  @override
  Future<void> addBookmark(Bookmark bookmark) {
    // TODO: implement addBookmark
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBookmark(String id) {
    // TODO: implement deleteBookmark
    throw UnimplementedError();
  }

  @override
  Future<Bookmark?> getBookmarkById(String id) {
    // TODO: implement getBookmarkById
    throw UnimplementedError();
  }
  
  // @override
  // // TODO: implement type
  // String get type => "test";

}