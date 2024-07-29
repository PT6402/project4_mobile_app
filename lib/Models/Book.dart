// import 'dart:convert';

// class Book {
//   final int? id;
//   final String? name; // Sử dụng name thay vì bookName
//   final int likeQty; // Chỉ cần trường likeQty, không cần price trong ví dụ này

//   Book({
//     this.id,
//     this.name,
//     required this.likeQty,
//   });

//   Book copyWith({
//     int? id,
//     String? name,
//     int? likeQty,
//   }) {
//     return Book(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       likeQty: likeQty ?? this.likeQty,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'likeQty': likeQty,
//     };
//   }

//   factory Book.fromMap(Map<String, dynamic> map) {
//     return Book(
//       id: map['bookId']?.toInt(),
//       name: map['bookName'],
//       likeQty: map['likeQty']?.toInt() ?? 0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Book.fromJson(Map<String, dynamic> json) {
//     return Book(
//       id: json['bookId']?.toInt(),
//       name: json['bookName'],
//       likeQty: json['likeQty']?.toInt() ?? 0,
//     );
//   }
// }
