import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/BookProvider.dart';
import 'package:testtem/Providers/WishlistProvider.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool _noBooksFound = false; // Thêm biến trạng thái

  @override
  void initState() {
    super.initState();
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.getBookStore(); // Fetch initial data
    bookProvider.getCateList(); // Fetch categories
    bookProvider.addListener(() {
      setState(() {
        _noBooksFound = bookProvider.Listbooks.isEmpty;
      });
    });
  }

  double _startRange = 0.0;
  double _endRange = 1000.0;
  String _selectedCategory = 'All Categories';
  double _selectedRating = 0.0;
  bool _isFilterExpanded = false;

  void _applyFilters() {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.setFilters(_startRange, _endRange, _selectedCategory, _selectedRating);
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                _isFilterExpanded = !_isFilterExpanded;
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: Container(), // Empty container when not expanded
            secondChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Range',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  RangeSlider(
                    values: RangeValues(_startRange, _endRange),
                    min: 0,
                    max: 1000,
                    divisions: 50,
                    labels: RangeLabels(
                      _startRange.toStringAsFixed(0),
                      _endRange.toStringAsFixed(0),
                    ),
                    onChanged: (values) {
                      setState(() {
                        _startRange = values.start;
                        _endRange = values.end;
                      });
                    },
                  ),
                  Text(
                    'Selected Range: \$${_startRange.toStringAsFixed(0)} - \$${_endRange.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: 'All Categories',
                        child: Text('All Categories'),
                      ),
                      ...bookProvider.cates.map<DropdownMenuItem<String>>((category) {
                        return DropdownMenuItem<String>(
                          value: category.name, // Assuming 'name' is the field in Categoryshow
                          child: Text(category.name),
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Book Ratings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RatingBar.builder(
                      initialRating: _selectedRating,
                      minRating: 0,
                      maxRating: 5,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 40,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _selectedRating = rating;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _applyFilters,
                    child: Text('Apply Filters'),
                  ),
                ],
              ),
            ),
            crossFadeState: _isFilterExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
          if (_noBooksFound) // Hiển thị thông báo nếu không có sách
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'THE BOOK NOT FOUND',
                style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                    bookProvider.hasMore) {
                  bookProvider.getBookStore();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: bookProvider.Listbooks.length + (bookProvider.hasMore ? 1 : 0),
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
                                      SizedBox(width: 5),
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
                            Positioned(
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
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                              ),
                                              child: Icon(
                                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                                color: isFavorite ? Colors.red : Colors.grey,
                                              ),
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
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
