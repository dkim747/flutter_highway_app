import 'package:app1/common_model/bookmark/repository/bookmark_repository.dart';
import 'package:app1/common_model/bookmark/repository/interface_bookmark_repository.dart';
import 'package:app1/common_model/bookmark/repository/test_bookmark_repository.dart';

class BookmarkRepositoryFactory {

  // final Map<String, BookmarkRepository> _bookmarkRepository = {

  //   "default" : DefaultBookmarkRepository(), 
  // };

  // final List<BookmarkRepository> _bookmarkRepository = [
  //   DefaultBookmarkRepository(),
  //   TestBookmarkRepository()
  // ];

  // BookmarkRepositoryFactory(this._bookmarkRepository);

  // BookmarkRepository getBookmarkService(String type) {
  //   return _bookmarkRepository.where((r) => r.type == type).first;
  // }

   final Map<String, BookmarkRepository Function()> _creators = {
    'default': () => DefaultBookmarkRepository(),
    'test': () => TestBookmarkRepository(),
  };

  final Map<String, BookmarkRepository> _cache = {};

  BookmarkRepository getBookmarkRepository(String type) {

    final creator = _creators[type];

    if (creator == null) {
      throw Exception('No BookmarkRepository registered for type "$type"');
    }

    if (!_cache.containsKey(type)) {
      _cache[type] = creator();
    }
    return _cache[type]!;
  }


}