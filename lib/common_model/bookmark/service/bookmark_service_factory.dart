import 'package:app1/common_model/bookmark/repository/bookmark_repository.dart';
import 'package:app1/common_model/bookmark/repository/test_bookmark_repository.dart';
import 'package:app1/common_model/bookmark/service/default_bookmark_service.dart';
import 'package:app1/common_model/bookmark/service/interface_bookmark_service.dart';
import 'package:app1/common_model/bookmark/service/test_bookmark_service.dart';

class BookmarkServiceFactory {

  // final BookmarkRepositoryFactory bookmarkRepositoryFactory;

  // BookmarkServiceFactory({
  //   required this.bookmarkRepositoryFactory
  // });

  // late final Map<String, BookmarkService Function()> _creators = {
  //   'default': () => DefaultBookmarkService(bookmarkRepositoryFactory: bookmarkRepositoryFactory),
  //   'test': () => TestBookmarkService(bookmarkRepositoryFactory: bookmarkRepositoryFactory),
  // };

  final Map<String, BookmarkService Function()> _creators = {
    'default': () => DefaultBookmarkService(bookmarkRepository: DefaultBookmarkRepository()),
    'test': () => TestBookmarkService(bookmarkRepository: TestBookmarkRepository()),
  };

  final Map<String, BookmarkService> _cache = {};

  BookmarkService getBookmarkService(String type) {

    final creator = _creators[type];

    if (creator == null) {
      throw Exception('No BookmarkService registered for type "$type"');
    }

    if (!_cache.containsKey(type)) {
      _cache[type] = creator();
    }
    return _cache[type]!;
  }

}