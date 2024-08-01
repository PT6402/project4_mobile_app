import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/Publisherdetail.dart';
import 'package:testtem/Providers/BookProvider.dart';

class PublisherPage extends StatefulWidget {
  final int pubId;

  PublisherPage({Key? key, required this.pubId}) : super(key: key);

  @override
  _PublisherPageState createState() => _PublisherPageState();
}

class _PublisherPageState extends State<PublisherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publisher Details"),
      ),
      body: FutureBuilder(
        future: Provider.of<BookProvider>(context, listen: false)
            .getPubDetail(widget.pubId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<BookProvider>(
              builder: (ctx, bookProvider, child) {
                PublisherDetail? publisherDetail = bookProvider.publisherDetail;
                if (publisherDetail == null) {
                  return Center(child: Text("Publisher not found"));
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (publisherDetail.image.isNotEmpty)
                            Center(
                              child: Image.memory(
                                publisherDetail.image,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(height: 30),
                          Text(
                            'Publisher: ${publisherDetail.name}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "${publisherDetail.name}'s book list",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          if (publisherDetail.bookList.isNotEmpty)
                            Column(
                              children: publisherDetail.bookList.map((book) {
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
                                    context.push("/bookdetail/${book.id}");
                                  },
                                );
                              }).toList(),
                            )
                          else
                            Center(
                              child: Text('No books found for this publish'),
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
