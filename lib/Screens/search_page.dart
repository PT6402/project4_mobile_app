import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/BookProvider.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        bookProvider.search(value);
                      } else {
                        bookProvider.search(
                            ''); // Clear search results if query is empty
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                      suffixIcon: DropdownButton<String>(
                        value: bookProvider.selectedCriteria,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            bookProvider.updateCriteria(newValue);
                            _controller.clear(); // Clear the text field
                            bookProvider.search(''); // Clear the search results
                          }
                        },
                        items: <String>['Book Name', 'Author Name', 'Publisher']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        itemHeight: 50,
                        dropdownColor: Colors.white,
                        isExpanded: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: bookProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : bookProvider.searchResults.isEmpty
                      ? Center(child: Text('No results found.'))
                      : ListView.builder(
                          itemCount: bookProvider.searchResults.length,
                          itemBuilder: (context, index) {
                            final result = bookProvider.searchResults[index];

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              elevation: 4.0,
                              child: Stack(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.all(8.0),
                                    leading: result.image.isNotEmpty
                                        ? Image.memory(
                                            result.image,
                                            width: 50,
                                            height: 75,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.book, size: 50),
                                    title: Text(result.name),
                                    subtitle: bookProvider.selectedCriteria ==
                                            'Book Name'
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Price: \$${result.price.toStringAsFixed(2)}'),
                                              Text(
                                                  'Rating: ${result.rating.toStringAsFixed(1)}'),
                                            ],
                                          )
                                        : null,
                                    onTap: () {
                                      if (bookProvider.selectedCriteria ==
                                          'Book Name') {
                                        context.push(
                                            "/bookDetail/${result.bookId}");
                                      } else if (bookProvider
                                              .selectedCriteria ==
                                          'Author Name') {
                                        context.push(
                                            "/authorDetail/${result.authorId}");
                                      } else {
                                        context.push(
                                            "/publisherDetail/${result.pubId}");
                                      }
                                    },
                                  ),
                                  Positioned(
                                    top: 30,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        var state =
                                            BlocProvider.of<AuthBloc>(context)
                                                .state;
                                        if (state.user == null) {
                                          context.pushNamed("login");
                                        }
                                      },
                                      child: Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
