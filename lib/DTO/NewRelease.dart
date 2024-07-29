import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class NewRelease {
  final int? id;
  final String? name; 
    final Uint8List image;
  NewRelease({
    this.id,
    this.name,
    required this.image,
  });

  NewRelease copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? name,
    Uint8List? image,
  }) {
    return NewRelease(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': base64Encode(image),
    };
  }

  factory NewRelease.fromMap(Map<String, dynamic> map) {
    return NewRelease(
      id: map['id']?.toInt(),
      name: map['name'],
      image: base64Decode(map['imagedata']),
    );
  }

  String toJson() => json.encode(toMap());

   factory NewRelease.fromJson(Map<String, dynamic> json) {
    return NewRelease(
      id: json['bookId']?.toInt(),
      name: json['bookName'],
      
      image: base64Decode(json['imagedata']),
    );
  }
}
