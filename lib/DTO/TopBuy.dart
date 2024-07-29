import 'dart:convert';
import 'dart:typed_data';

class TopBuy {
  final int? id;
  final String? name; 
  final int boughtBooks; 
    final Uint8List image;

  TopBuy({
    this.id,
    this.name,
    required this.boughtBooks,
    required this.image,
  });

  TopBuy copyWith({
    int? id,
    String? name,
    int? boughtBooks,
    Uint8List? image,
  }) {
    return TopBuy(
      id: id ?? this.id,
      name: name ?? this.name,
      boughtBooks: boughtBooks ?? this.boughtBooks,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'boughtBooks': boughtBooks,
      'image': base64Encode(image),
    };
  }

  factory TopBuy.fromMap(Map<String, dynamic> map) {
    return TopBuy(
      id: map['bookId']?.toInt(),
      name: map['bookName'],
      boughtBooks: map['boughtBooks']?.toInt() ?? 0,
      image: base64Decode(map['imagedata']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopBuy.fromJson(Map<String, dynamic> json) {
    return TopBuy(
      id: json['bookId']?.toInt(),
      name: json['bookName'],
      boughtBooks: json['boughtBooks']?.toInt() ?? 0,
        image: base64Decode(json['imagedata']),
    );
  }
}
