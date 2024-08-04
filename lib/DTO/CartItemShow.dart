import 'dart:convert';

class CartItemShow {
  final int cartId;
  final int cartItemId;
  final int bookId;
  final String bookName;
  late final int packId;
  late final bool ibuy;
  final double priceBuy;
  final List<PackageShowbook> packlist;
  final String imageData;

  CartItemShow({
    required this.cartId,
    required this.cartItemId,
    required this.bookId,
    required this.bookName,
    required this.packId,
    required this.ibuy,
    required this.priceBuy,
    required this.packlist,
    required this.imageData,
  });

  factory CartItemShow.fromJson(Map<String, dynamic> json) {
    return CartItemShow(
      cartId: json['cartId'],
      cartItemId: json['cartItemId'],
      bookId: json['bookId'],
      bookName: json['bookName'],
      packId: json['packId'],
      ibuy: json['ibuy'],
      priceBuy: json['priceBuy'],
      packlist: (json['packlist'] as List)
          .map((i) => PackageShowbook.fromJson(i))
          .toList(),
      imageData: json['imageData'],
    );
  }
}

class PackageShowbook {
  final int id;
  final String packageName;
  final int dayQuantity;
  final double rentPrice;

  PackageShowbook({
    required this.id,
    required this.packageName,
    required this.dayQuantity,
    required this.rentPrice,
  });

  factory PackageShowbook.fromJson(Map<String, dynamic> json) {
    return PackageShowbook(
      id: json['id'],
      packageName: json['packageName'],
      dayQuantity: json['dayQuantity'],
      rentPrice: json['rentPrice'],
    );
  }
}
