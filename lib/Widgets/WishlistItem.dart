import 'package:flutter/material.dart';

import 'package:testtem/Screens/Wishlist.dart';


class WishlistItem extends StatelessWidget {
  final Book book;

  const WishlistItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(book.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(book.title),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            // if (value == 'details') {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
            //   );
            // } else if (value == 'remove') {
            //   // Xóa khỏi wishlist
            //   // Xử lý logic xóa khỏi danh sách yêu thích ở đây
            // }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'details',
              child: Text('Chi tiết sách'),
            ),
            PopupMenuItem(
              value: 'remove',
              child: Text('Xoá khỏi mục yêu thích'),
            ),
          ],
        ),
      ),
    );
  }
}