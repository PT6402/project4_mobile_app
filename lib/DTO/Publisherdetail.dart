import 'dart:convert';
import 'dart:typed_data';

import 'package:testtem/DTO/Authordetail.dart';

class PublisherDetail {
  final String name;
  final String description;
  final Uint8List image;
  final List<Book> bookList;

  PublisherDetail({
    required this.name,
    required this.description,
    required this.image,
    required this.bookList,
  });

  factory PublisherDetail.fromJson(Map<String, dynamic> json) {
    return PublisherDetail(
      name: json['name'] ?? 'Unknown',
       description: json['description'] ?? 'nothing',
      image: base64Decode(json['image'] ?? ''),
      bookList: (json['listBook'] as List<dynamic>? ?? [])
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}