import 'dart:convert';
import 'dart:typed_data';

class Order {
  final int orderId;
  final bool paymentStatus;
  final List<OrderDetails> orderDetails;

  Order({
    required this.orderId,
    required this.paymentStatus,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] ?? 0,
      paymentStatus: (json['paymentStatus'] ?? 0) == 1, // Điều chỉnh nếu cần
      orderDetails: (json['orderDetailsFlutter'] as List<dynamic>? ?? [])
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
  final List<ReviewDetail> reviews;

  OrderDetails({
    required this.bookId,
    required this.bookName,
    required this.price,
    required this.dayPackage,
    required this.image,
    required this.packId,
    this.packName,
    required this.reviews,
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
      packName: json['packName'],
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((review) => ReviewDetail.fromJson(review))
          .toList(),
    );
  }
}

class ReviewDetail {
 double star;
   String content;
  final int id;
  final DateTime createDate;

  ReviewDetail({
    required this.star,
    required this.content,
    required this.id,
    required this.createDate,
  });

  factory ReviewDetail.fromJson(Map<String, dynamic> json) {
    return ReviewDetail(
      star: (json['star'] ?? 0.0).toDouble(),
      content: json['content'] ?? '',
      id: json['id'] ?? 0,
      createDate: DateTime.parse(json['createDate'] ?? '1970-01-01T00:00:00.000Z'), // Đặt giá trị mặc định nếu không có
    );
  }

  void setStar(double newStar) {
    star = newStar;
  }

  void setContent(String newContent) {
    content = newContent;
  }
}
