import 'dart:convert';
import 'dart:typed_data';

class Book {
  final int id;
  final String name;
  final double price;
  final Uint8List image;

  Book({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: base64Decode(json['image'] ?? ''),
    );
  }
}

class AuthorDetail {
  final String name;
  final Uint8List image;
  final List<Book> bookList;

  AuthorDetail({
    required this.name,
    required this.image,
    required this.bookList,
  });

  factory AuthorDetail.fromJson(Map<String, dynamic> json) {
    return AuthorDetail(
      name: json['name'] ?? 'Unknown',
      image: base64Decode(json['image'] ?? ''),
      bookList: (json['listBook'] as List<dynamic>? ?? [])
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
