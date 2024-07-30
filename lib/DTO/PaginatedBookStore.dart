import 'dart:convert';
import 'dart:typed_data';

class PaginatedBookStore {
  final int totalPage;
  final List<BookStore> paglist;

  PaginatedBookStore({
    required this.totalPage,
    required this.paglist,
  });

  factory PaginatedBookStore.fromJson(Map<String, dynamic> json) {
    return PaginatedBookStore(
      totalPage: json['totalPage'] ?? 0,
      paglist: (json['paglist'] as List<dynamic>? ?? [])
          .map((item) => BookStore.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BookStore {
  final int id;
  final String name;
  final List<AuthorUserRes> authorlist;
  // final String publisher;
  final double price;
  final double rating;
  final Uint8List image;
  final List<CateShow> catelist;

  BookStore({
    required this.id,
    required this.name,
    required this.authorlist,
    // required this.publisher,
    required this.price,
    required this.rating,
    required this.image,
    required this.catelist,
  });

  factory BookStore.fromJson(Map<String, dynamic> json) {
    return BookStore(
      id: json['bookid'] ?? 0,
      name: json['name'] ?? 'Unknown',
      authorlist: (json['authors'] as List<dynamic>? ?? [])
          .map((e) => AuthorUserRes.fromJson(e as Map<String, dynamic>))
          .toList(),
       // Kiểm tra có trường publisher không
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      image: base64Decode(json['imageCove'] ?? ''),
      catelist: (json['catelist'] as List<dynamic>? ?? [])
          .map((e) => CateShow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AuthorUserRes {
  final int id;
  final String name;

  AuthorUserRes({
    required this.id,
    required this.name,
  });

  factory AuthorUserRes.fromJson(Map<String, dynamic> json) {
    return AuthorUserRes(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
    );
  }
}

class CateShow {
  final int id;
  final String name;

  CateShow({
    required this.id,
    required this.name,
  });

  factory CateShow.fromJson(Map<String, dynamic> json) {
    return CateShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
    );
  }
}
