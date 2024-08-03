import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/WishlistProvider.dart';
import 'package:testtem/Widgets/WishlistItem.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

    @override
  void initState(){
    super.initState();
    final wishlistprovider=Provider.of<WishListProvider>(context,listen: false);
    wishlistprovider.getWishlist();
  }
 

  

  @override
  Widget build(BuildContext context) {
    final wishProvider = Provider.of<WishListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          
          Expanded(
            child: ListView.builder(
              itemCount: wishProvider.listshow.length,
              itemBuilder: (context, index) {
                final book = wishProvider.listshow[index];
                return WishlistItem(book: book);
              },
            ),
          ),
        ],
      ),
    );
  }
}
