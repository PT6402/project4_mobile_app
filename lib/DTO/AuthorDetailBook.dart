import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';



class AuthorDetailBook {
  final int bookId;
  final String name;
  final String description;
  final Uint8List image;
  final int authorId;
  final double price;
  final double rating;
  final int pubId;


  AuthorDetailBook({
    required this.bookId,
    required this.name,
    required this.description,
    required this.image,
    required this.authorId,
    required this.price,
    required this.rating,
    required this.pubId,
    
  });

  factory AuthorDetailBook.fromJson(Map<String, dynamic> json) {
    return AuthorDetailBook(
      bookId: json['bookid'] ?? 0,
      authorId: json['authorId'] ?? 0,
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      image: base64Decode(json['imageCove'] ?? ''),
      pubId: json['pubId'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      
    );
  }
}




