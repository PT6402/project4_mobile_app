import 'dart:typed_data';
import 'dart:convert';

class MyBook {
  final int bookId;
  final String bookName;
  final DateTime dayGet;
  final DateTime? dayExpired;
  final int dayTotal;
  final bool status;
  final Uint8List? fileimage;

  MyBook({
    required this.bookId,
    required this.bookName,
    required this.dayGet,
    this.dayExpired,
    required this.dayTotal,
    required this.status,
    this.fileimage,
  });

  factory MyBook.fromJson(Map<String, dynamic> json) {
    return MyBook(
      bookId: json['id'] as int,
      bookName: json['bookname'] as String,
      dayGet: DateTime.parse(json['dayGet'] as String),
      dayExpired: json['dayExpired'] != null
          ? DateTime.parse(json['dayExpired'] as String)
          : null,
      dayTotal: json['dayTotal'] as int,
      status: json['status'] == 0 ? false : true,
      fileimage: json['fileimage'] != null
          ? base64Decode(json['fileimage'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': bookId,
      'bookname': bookName,
      'dayGet': dayGet.toIso8601String(),
      'dayExpired': dayExpired?.toIso8601String(),
      'dayTotal': dayTotal,
      'status': status ? 1 : 0,
      'fileimage': fileimage != null ? base64Encode(fileimage!) : null,
    };
  }
}
