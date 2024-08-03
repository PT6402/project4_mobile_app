import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/WishlistShow.dart';
import 'package:testtem/Providers/WishlistProvider.dart';

class WishlistItem extends StatelessWidget {
  final Wishlistshow book;

  const WishlistItem({required this.book});
    void _deleteBook(BuildContext context) async {
    final wishProvider = Provider.of<WishListProvider>(context, listen: false);
    await wishProvider.deleteWish(book.bookid);
    await wishProvider.getWishlist(); // Update the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.memory(book.fileImage, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(book.bookname),
        subtitle: Text(' Price: ${book.price}'),
      
        trailing: IconButton(icon: Icon(Icons.delete),
       onPressed: () => _deleteBook(context), 
          
        )
      ),
    );
  }
}
