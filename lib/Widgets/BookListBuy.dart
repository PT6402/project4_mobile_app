import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/TopBuy.dart';
import 'package:testtem/Providers/BookProvider.dart';
import 'package:testtem/Providers/WishlistProvider.dart';
import 'package:testtem/Screens/BookDetailPage.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
class BookListBuy extends StatefulWidget {
  final String title;
  final List<TopBuy> books;
  const BookListBuy({super.key, required this.title, required this.books,});

  @override
  State<BookListBuy> createState() => _BookListBuyState();
}

class _BookListBuyState extends State<BookListBuy> {
   bool _isInit = true;
    @override
  void didChangeDependencies() {
    if (_isInit) {
     
      final wishlistprovider=Provider.of<WishListProvider>(context,listen: false);
      wishlistprovider.getWishlist();
     
      
      _isInit = false;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.books.length,
            itemBuilder: (context, index) {
              final book = widget.books[index];
              final bookName = book.name ?? 'Unknown'; // Cung cấp giá trị mặc định nếu book.name là null
              final bookBuy = book.boughtBooks.toString(); // Chuyển đổi boughtBooks thành chuỗi

              return GestureDetector(
                onTap: () {
                  context.push("/bookDetail/${book.id}");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.memory(
                                book.image,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 150,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.grey.withOpacity(0.5),
                              child: Row(
                                children: [
                                  Icon(Icons.shopping_bag_outlined, color: Colors.red),
                                  Text(
                                    bookBuy,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Consumer<WishListProvider>(
                              builder: (context, wishlistProvider, child) {
                                var state = BlocProvider.of<AuthBloc>(context).state;
                               
                                return FutureBuilder<bool>(
                                  future: state.user != null ? wishlistProvider.checkStatus(book.id!) : Future.value(false),
                                  builder: (context, snapshot) {
                                    bool isFavorite = snapshot.data ?? false;
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return GestureDetector(
                                          onTap: () async {
                                            if (state.user == null) {
                                              context.pushNamed("login");
                                            } else {
                                              if (isFavorite) {
                                                await wishlistProvider.deleteWish(book.id!);
                                              } else {
                                                await wishlistProvider.addWish(book.id!);
                                              }
                                              // Cập nhật lại trạng thái yêu thích
                                              bool newStatus = await wishlistProvider.checkStatus(book.id!);
                                              setState(() {
                                                isFavorite = newStatus;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      SizedBox(
                        width: 100, // Đặt chiều rộng cho SizedBox
                        child: Text(
                          bookName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
