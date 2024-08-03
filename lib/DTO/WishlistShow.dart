import 'dart:convert';
import 'dart:typed_data';

class Wishlistshow {
  final int bookid;
  final String bookname;
  final double rating;
  final int wishid;
  final double price;
  final Uint8List fileImage;
  Wishlistshow({
    required this.bookid,
    required this.bookname,
    required this.rating,
    required this.wishid,
    required this.price,
    required this.fileImage,
  });


  factory Wishlistshow.fromJson(Map<String, dynamic> json) {
    return Wishlistshow(
      bookid: json['bookid']?.toInt() ?? 0,
      bookname: json['bookname'] ?? 'Unknown',
      rating: json['rating']?.toDouble() ?? 0.0,
      wishid: json['wishid']?.toInt() ?? 0,
      price: json['price']?.toDouble() ?? 0.0,
      fileImage: base64Decode(json['fileImage']),
    );
  }


}
