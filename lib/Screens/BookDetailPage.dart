import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/BookProvider.dart';
import 'package:testtem/Providers/CartProvider.dart';
import '../DTO/BookDetail.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  BookDetailPage({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  PackageShowbook? _selectedPackage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: FutureBuilder(
        future: Provider.of<BookProvider>(context, listen: false)
            .getBookDetail(widget.bookId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<BookProvider>(
              builder: (ctx, bookProvider, child) {
                BookDetail? bookDetail = bookProvider.bookDetail;
                if (bookDetail == null) {
                  return Center(child: Text('Book not found'));
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          if (bookDetail.imageUrl.isNotEmpty)
                            Image.memory(base64Decode(bookDetail.imageUrl)),
                          SizedBox(height: 10),
                          Text(
                            bookDetail.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'by ${bookDetail.authorlist.map((author) => author.name).join(', ')}',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Publisher: ${bookDetail.publisher}',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Price: \$${bookDetail.price}',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Categories: ${bookDetail.catelist.map((category) => category.name).join(', ')}',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(bookDetail.description),
                              SizedBox(height: 10),
                              Text(
                                'Pages: ${bookDetail.pages}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Rating: ${bookDetail.rating} (${bookDetail.reviewsCount} reviews)',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Customer Reviews',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              ...bookDetail.reviewList
                                  .map((review) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${review.username}',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        SizedBox(width: 10),
                                        Row(
                                          children:
                                          List.generate(5, (index) {
                                            return Icon(
                                              index < review.rating
                                                  ? Icons.star
                                                  : Icons.star_border,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    Text(review.content),
                                  ],
                                ),
                              ))
                                  .toList(),
                              SizedBox(height: 20),
                              Text(
                                'Purchase Options',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              DropdownButton<PackageShowbook>(
                                hint: Text('Select an option'),
                                value: _selectedPackage,
                                items: [
                                  DropdownMenuItem<PackageShowbook>(
                                    value: null,
                                    child: Text('Buy - \$${bookDetail.price}'),
                                  ),
                                  ...bookDetail.packlist.map((PackageShowbook package) {
                                    return DropdownMenuItem<PackageShowbook>(
                                      value: package,
                                      child: Text(
                                        '${package.packageName} - \$${package.rentPrice} for ${package.dayQuantity} days',
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPackage = value;
                                  });
                                },
                              ),

                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  final cartProvider = Provider.of<CartProvider>(context, listen: false);

                                  try {
                                    await cartProvider.addToCart(
                                      widget.bookId,
                                      _selectedPackage == null,
                                      packId: _selectedPackage?.id ?? 0,
                                    );

                                    await cartProvider.getCartForUpdate();

                                    // Show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Book added to cart successfully!'),
                                      ),
                                    );
                                  } catch (e) {
                                    // Show error message if adding to cart fails
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to add book to cart. Please try again.'),
                                      ),
                                    );
                                  }
                                },
                                child: Text('Add to Cart'),
                              ),

                            ],
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
