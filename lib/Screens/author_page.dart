import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/Authordetail.dart';
import 'package:testtem/Providers/BookProvider.dart'; // Cập nhật đúng đường dẫn

class AuthorPage extends StatefulWidget {
  final int authorId;

  AuthorPage({Key? key, required this.authorId}) : super(key: key);

  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author Details'),
      ),
      body: FutureBuilder(
        future: Provider.of<BookProvider>(context, listen: false)
            .getAuthorDetail(widget.authorId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<BookProvider>(
              builder: (ctx, bookProvider, child) {
                AuthorDetail? authorDetail = bookProvider.authorDetail;
                if (authorDetail == null) {
                  return Center(child: Text('Author not found'));
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (authorDetail.image.isNotEmpty)
                            Center(
                              child: Image.memory(
                                authorDetail.image,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          // SizedBox(height: 10),
                          // Text(
                          //   authorDetail.name,
                          //   style: TextStyle(
                          //       fontSize: 24, fontWeight: FontWeight.bold),
                          //   textAlign: TextAlign.center,
                          // ),
                          SizedBox(height: 20),
                          Text(
                            'Books by ${authorDetail.name}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 20),
                          Text(
                            "${authorDetail.name}'s book list" ,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                            
                          ),
                          SizedBox(height: 10),
                          if (authorDetail.bookList.isNotEmpty)
                            Column(
                              children: authorDetail.bookList.map((book) {
                                return ListTile(
                                  leading: book.image.isNotEmpty
                                      ? Image.memory(
                                          book.image,
                                          width: 50, 
                                          height: 75, 
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.book),
                                  title: Text(book.name),
                                  subtitle: Text('Price: \$${book.price}'),
                                  onTap: () {
                                     context.push("/bookDetail/${book.id}");
                                  },
                                );
                              }).toList(),
                            )
                          else
                            Center(
                              child: Text('No books found for this author'),
                            ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
