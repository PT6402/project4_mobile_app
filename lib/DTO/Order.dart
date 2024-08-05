import 'dart:convert';
import 'dart:typed_data';

class Order {
  final int orderId;
  final bool paymentStatus;
  final List<OrderDetails> orderDetails;

  Order({required this.orderId, required this.paymentStatus, required this.orderDetails});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] ?? 0,
      paymentStatus: (json['paymentStatus'] ?? 0) == 1, // Convert int to bool
      orderDetails: (json['orderDetails'] as List? ?? [])
          .map((detail) => OrderDetails.fromJson(detail))
          .toList(),
    );
  }
}

class OrderDetails {
  final int bookId;
  final String bookName;
  final double price;
  final int dayPackage;
  final Uint8List image;
  final int packId;
  final String? packName;
  final ReviewDetail review;

  OrderDetails({
    required this.bookId,
    required this.bookName,
    required this.price,
    required this.dayPackage,
    required this.image,
    required this.packId,
    this.packName,
    required this.review,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      bookId: json['bookId'] ?? 0,
      bookName: json['bookName'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      dayPackage: json['dayPackage'] ?? 0,
      image: json['image'] != null
          ? base64Decode(json['image'])
          : Uint8List(0),
      packId: json['packId'] ?? 0,
      packName: json['packName'] ?? '',
      review: json['review'] != null
          ? ReviewDetail.fromJson(json['review'])
          : ReviewDetail(star: 0.0, content: '', id: 0),
    );
  }
}

class ReviewDetail {
  double star;
  String content;
  int id;

  ReviewDetail({required this.star, required this.content, required this.id});

  factory ReviewDetail.fromJson(Map<String, dynamic> json) {
    return ReviewDetail(
      star: (json['star'] ?? 0.0).toDouble(),
      content: json['content'] ?? '',
      id: json['id'] ?? 0,
    );
  }

  void setStar(double newStar) {
    star = newStar;
  }

  void setContent(String newContent) {
    content = newContent;
  }
}
