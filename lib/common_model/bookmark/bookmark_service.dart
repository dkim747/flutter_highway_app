// import 'package:app1/common_model/bookmark/bookmark.dart';
// import 'package:app1/common_model/bookmark/repository/bookmark_repository_factory.dart';
// import 'package:app1/common_model/bookmark/repository/interface_bookmark_repository.dart';

// class BookmarkService {

//   final BookmarkRepositoryFactory bookmarkRepositoryFactory;

//   BookmarkService(this.bookmarkRepositoryFactory);  

//   Future<void> addBookmark(Bookmark bookmark, String type) async {

//     final BookmarkRepository bookmarkRepository = bookmarkRepositoryFactory.getBookmarkRepository(type);
 
//     final existing = await bookmarkRepository.findBookmarkById(bookmark.id);
//     if (existing == null) {
//       await bookmarkRepository.insertBookmark(bookmark);
//     }
//   }

//   Future<Bookmark?> getBookmarkById(String id, String type) async {
//     final BookmarkRepository bookmarkRepository = bookmarkRepositoryFactory.getBookmarkRepository(type);

//     Bookmark? bookmark = await bookmarkRepository.findBookmarkById(id);

//     return bookmark;
//   }

//   Future<void> deleteBookmark(String id, String type) async {
//     final BookmarkRepository bookmarkRepository = bookmarkRepositoryFactory.getBookmarkRepository(type);

//     final existing = await bookmarkRepository.findBookmarkById(id);
//     if (existing != null) {
//       await bookmarkRepository.deleteBookmark(id);
//     }
//   }
// }