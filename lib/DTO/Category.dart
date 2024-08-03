import 'dart:convert';
import 'dart:typed_data';

class Categoryshow {
  final int id;
  final String name;
  final String description;
  final Uint8List imagedata;

  Categoryshow({
    required this.id,
    required this.name,
    required this.description,
    required this.imagedata,
  });

  factory Categoryshow.fromJson(Map<String, dynamic> json) {
    return Categoryshow(
      id: json['id'] ?.toInt(),
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'nothing',
      imagedata: base64Decode(json['imagedata']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagedata': base64Encode(imagedata),
    };
  }

  factory Categoryshow.fromMap(Map<String, dynamic> map) {
    return Categoryshow(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imagedata: base64Decode(map['imagedata']),
    );
  }

  String toJson() => json.encode(toMap());

 
}
