import 'dart:convert';

class BookDetail {
  final int id;
  final String name;
  final String author;
  final String publisher;
  final double price;
  final String description;
  final int pages;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final List<ReviewShow1> reviewList;
  final List<PackageShowbook> packlist;

  BookDetail({
    required this.id,
    required this.name,
    required this.author,
    required this.publisher,
    required this.price,
    required this.description,
    required this.pages,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.reviewList,
    required this.packlist,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) {
    return BookDetail(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      author: (json['authorlist'] != null && json['authorlist'].isNotEmpty)
          ? json['authorlist'][0]['name'] ?? 'Unknown'
          : 'Unknown',
      publisher: json['pubname'] ?? 'Unknown',
      price: json['priceBuy']?.toDouble() ?? 0.0,
      description: json['description'] ?? 'No description available',
      pages: json['pageQuantity'] ?? 0,
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewsCount: json['ratingQuantity'] ?? 0,
      imageUrl: json['fileimage'] ?? '',
      reviewList: (json['reviewlist'] as List).map((e) => ReviewShow1.fromJson(e)).toList(),
      packlist: (json['packlist'] as List).map((e) => PackageShowbook.fromJson(e)).toList(),
    );
  }
}

class ReviewShow1 {
  final String username;
  final double rating;
  final String content;

  ReviewShow1({
    required this.username,
    required this.rating,
    required this.content,
  });

  factory ReviewShow1.fromJson(Map<String, dynamic> json) {
    return ReviewShow1(
      username: json['username'],
      rating: json['rating'],
      content: json['content'],
    );
  }
}

class PackageShowbook {
  final String packageName;
  final double rentPrice;
  final int dayQuantity;

  PackageShowbook({
    required this.packageName,
    required this.rentPrice,
    required this.dayQuantity,
  });

  factory PackageShowbook.fromJson(Map<String, dynamic> json) {
    return PackageShowbook(
      packageName: json['packageName'],
      rentPrice: json['rentPrice']?.toDouble() ?? 0.0,
      dayQuantity: json['dayQuantity'] ?? 0,
    );
  }
}