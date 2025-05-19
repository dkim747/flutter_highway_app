import 'package:app1/common_model/bookmark/bookmark.dart';
import 'package:app1/common_model/bookmark/service/interface_bookmark_service.dart';
import 'package:app1/common_widgets/snackbar.dart';
import 'package:flutter/material.dart';

class BookmarkWidget extends StatelessWidget {

  final bool isFavorite;
  final double width;
  final double height;
  final IconData icon;
  final VoidCallback onTabFavorite;
  final Color iconColorOn;
  final Color iconColorOff;
  final Color backgroundColorOn;
  final Color backgroundColorOff;
  final BookmarkService bookmarkService;
  final Bookmark bookmark;

  const BookmarkWidget({
    super.key, 
    required this.isFavorite, 
    required this.width, 
    required this.height, 
    required this.icon, 
    required this.onTabFavorite, 
    required this.iconColorOn, 
    required this.iconColorOff, 
    required this.backgroundColorOn, 
    required this.backgroundColorOff, 
    required this.bookmarkService,
    required this.bookmark
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: isFavorite ? backgroundColorOn : backgroundColorOff,
        width: width,
        height: height,
        child: Icon(
          icon,
          color: isFavorite ? iconColorOn : iconColorOff,
        ),
      ),
      onTap: () {
        onTabFavorite();
        if(!isFavorite) {
                Snackbar(
                  text: "즐겨찾기 등록"
                ).showSnackbar(context);

                bookmarkService.addBookmark(bookmark);

              } else {
                Snackbar(
                    text: "즐겨찾기 해제"
                ).showSnackbar(context);

                bookmarkService.deleteBookmark(bookmark.id);
              }
      },
    );
  }
}