import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testtem/DTO/TopBuy.dart';
import 'package:testtem/Screens/BookDetailPage.dart';

class BookListBuy extends StatelessWidget {
  final String title;
  final List<TopBuy> books;

  BookListBuy({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final bookName = book.name ??
                  'Unknown'; // Cung cấp giá trị mặc định nếu book.name là null
              final bookBuy = book.boughtBooks
                  .toString(); // Chuyển đổi boughtBooks thành chuỗi

              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => BookDetailPage(bookId: book.id!)),
                  // );
                  context.push("/bookDetail/${book.id!}");
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
                                book.image, // Đảm bảo chuyển đổi từ base64 sang byte
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
                              padding: const EdgeInsets.all(4.0),
                              color: Colors.black.withOpacity(0.5),
                              child: Row(
                                children: [
                                  Icon(Icons.shopping_bag_outlined,
                                      color: Colors.red),
                                  Text(
                                    bookBuy,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Text(
                        bookName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
