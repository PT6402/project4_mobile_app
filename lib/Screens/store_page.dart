import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/BookProvider.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.getBookStore();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              bookProvider.hasMore) {
            bookProvider.getBookStore();
          }
          return false;
        },
        child: ListView.builder(
          itemCount:
              bookProvider.Listbooks.length + (bookProvider.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == bookProvider.Listbooks.length) {
              return Center(child: CircularProgressIndicator());
            }
            final book = bookProvider.Listbooks[index];
            return GestureDetector(
              onTap: () {
                 context.push("/bookDetail/${book.id}");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: book.image.isNotEmpty
                            ? Image.memory(book.image, fit: BoxFit.cover)
                            : Center(
                                child: Text(
                                  'No Image',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              book.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Author: ${book.authorlist.isNotEmpty ? book.authorlist.map((a) => a.name).join(", ") : 'Unknown'}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Price: \$${book.price.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Rating:',
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                    width: 5), // Khoảng cách giữa text và icon
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  '${book.rating.toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
