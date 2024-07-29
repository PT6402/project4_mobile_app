import 'package:flutter/material.dart';
import 'package:testtem/Widgets/WishlistItem.dart';


class WishlistScreen extends StatelessWidget {
  WishlistScreen();
  final List<Book> wishlistBooks = [
    Book('Book 1', 'assets/book1.jpg'),
    Book('Book 2', 'assets/book2.jpg'),
    // Thêm các sách yêu thích khác
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.favorite, size: 80, color: Colors.red),
                Text('Wishlist', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wishlistBooks.length,
              itemBuilder: (context, index) {
                return WishlistItem(book: wishlistBooks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  final String title;
  final String image;

  Book(this.title, this.image);
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
    };
  }
}
