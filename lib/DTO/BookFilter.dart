import 'dart:typed_data';

import 'dart:convert';

class BookFilter {
  final int? id; // Changed to int? to handle nullable IDs
  final String? name; // Changed to String? to handle nullable names
  final double? price; // Changed to double? to handle nullable prices
  final double? rating; // Changed to double? to handle nullable ratings

  BookFilter({
    this.id,
    this.name,
    this.price,
    this.rating,
  });

  factory BookFilter.fromJson(Map<String, dynamic> json) {
    return BookFilter(
      id: json['bookid'] as int?, // Cast to int? to handle null values
      name: json['name'] as String?, // Cast to String? to handle null values
      price: json['price'] != null ? (json['price'] as num).toDouble() : null, // Handle null and type casting
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null, // Handle null and type casting
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'bookid': id,
      'name': name,
      'price': price,
      'rating': rating,
    };
  }
}

class BookFilterIn {
  final double? rating;
  final int? from;
  final int? to;
  final List<int>? list;

  BookFilterIn({this.rating, this.from, this.to, this.list});

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'from': from,
      'to': to,
      'list': list,
    };
  }
}




class BookListResponse {
  final int totalPage;
  final List<BookFilter> pagList;

  BookListResponse({
    required this.totalPage,
    required this.pagList,
  });

  factory BookListResponse.fromJson(Map<String, dynamic> json) {
    return BookListResponse(
      totalPage: json['totalPage'] as int, // Ensure totalPage is always an int
      pagList: (json['paglist'] as List<dynamic>).map((item) {
        return BookFilter.fromJson(item as Map<String, dynamic>); // Ensure type casting
      }).toList(),
    );
  }
}

