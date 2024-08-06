import 'dart:convert';
import 'dart:typed_data';

class ImageBook {
  final int id;
  final String imageName;
  final bool currentImage;
  final Uint8List imageData;

  ImageBook({
    required this.id,
    required this.imageName,
    required this.currentImage,
    required this.imageData,
  });

  factory ImageBook.fromJson(Map<String, dynamic> json) {
    return ImageBook(
      id: json['id'],
      imageName: json['image_name'],
      currentImage: json['current_image'],
      imageData: base64Decode(json['image_data']), 
    );
  }
}