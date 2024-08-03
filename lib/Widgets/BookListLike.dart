import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/TopLike.dart';
import 'package:testtem/Providers/WishlistProvider.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';

class BookListLike extends StatelessWidget {
  final String title;
  final List<TopLike> books;

  BookListLike({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final bookName = book.name ?? 'Unknown';
              final booklike = book.likeQty.toString();

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
                                  Icon(Icons.person, color: Colors.red),
                                  Text(
                                    booklike,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
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
                        width: 100,
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
