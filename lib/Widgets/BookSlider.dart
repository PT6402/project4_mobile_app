import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/NewRelease.dart';
import 'package:go_router/go_router.dart';
import 'package:testtem/Providers/WishlistProvider.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart'; // Make sure to import GoRouter

class BookSlider extends StatelessWidget {
  final String title;
  final List<NewRelease> books;

  BookSlider({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 8 / 4,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: books.map((book) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    context.push("/bookDetail/${book.id}");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: MemoryImage(book.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.blueGrey.withOpacity(0.3),
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              book.name ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
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
                            ),),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
