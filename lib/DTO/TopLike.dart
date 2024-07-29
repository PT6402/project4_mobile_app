import 'dart:convert';
import 'dart:typed_data';

class TopLike {
  final int? id;
  final String? name;
  final int likeQty;
  final Uint8List image;

  TopLike({
    this.id,
    this.name,
    required this.likeQty,
    required this.image,
  });

  TopLike copyWith({
    int? id,
    String? name,
    int? likeQty,
    Uint8List? image,
  }) {
    return TopLike(
      id: id ?? this.id,
      name: name ?? this.name,
      likeQty: likeQty ?? this.likeQty,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'likeQty': likeQty,
      'image': base64Encode(image),
    };
  }

  factory TopLike.fromMap(Map<String, dynamic> map) {
    return TopLike(
      id: map['bookId']?.toInt(),
      name: map['bookName'],
      likeQty: map['likeQty']?.toInt() ?? 0,
      image: base64Decode(map['imagedata']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopLike.fromJson(Map<String, dynamic> json) {
    return TopLike(
      id: json['bookId']?.toInt(),
      name: json['bookName'],
      likeQty: json['likeQty']?.toInt() ?? 0,
      image: base64Decode(json['imagedata']),
    );
  }
}
