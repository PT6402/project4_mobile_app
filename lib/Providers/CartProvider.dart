import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:testtem/DTO/BookDetail.dart' as bookDetail;
import 'package:testtem/DTO/CartItemShow.dart';

import '../core/secure_storage/storage_token.dart';

class CartProvider with ChangeNotifier {
  final StorageToken bearerToken;
  Logger logger = Logger();
  dynamic selectedPackage;
  CartProvider(this.bearerToken);

  final String apiUrlViewCart = "http://192.168.1.22:9090/api/v1/cart";
  final String apiUrlAddToCart = "http://192.168.1.22:9090/api/v1/cart";
  final String apiUrlRemoveFromCart = "http://192.168.1.22:9090/api/v1/cart";
  final String apiUrlUpdateCart = "http://192.168.1.22:9090/api/v1/cart";

  List<CartItemShow> _cartItems = [];

  List<CartItemShow> get cartItems => _cartItems;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  Future<List<CartItemShow>?> viewCart() async {
    _isLoading = true;
    notifyListeners();
    final accessToken = await bearerToken.getAccessToken();
    print('Access token: ${accessToken}');

    try {
      final response = await http.get(
        Uri.parse(apiUrlViewCart),
        headers: {
          'Authorization': 'Bearer ${accessToken}',
          // Replace with your actual token
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        _cartItems = (data['model'] as List)
            .map((json) => CartItemShow.fromJson(json))
            .toList();
        calculateTotalPrice();
        notifyListeners();
        return _cartItems;
      } else {
        print('Failed to load cart data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching cart data: $e');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void calculateTotalPrice() {
    _totalPrice = 0.0;
    for (var item in _cartItems) {
      if (item.ibuy) {
        _totalPrice += item.priceBuy;
      } else {
        final selectedPackage = item.packlist.firstWhere(
              (pack) => pack.id == item.packId,
          orElse: () => PackageShowbook(
            id: 0,
            packageName: "Default",
            dayQuantity: 0,
            rentPrice: 0.0,
          ),
        );
        _totalPrice += selectedPackage.rentPrice;
      }
    }
    notifyListeners();
  }

  Future<void> getCartForUpdate() async {
    _isLoading = true;
    notifyListeners();
    final accessToken = await bearerToken.getAccessToken();
    print('Access token: ${accessToken}');

    try {
      final response = await http.get(
        Uri.parse(apiUrlViewCart),
        headers: {
          'Authorization': 'Bearer ${accessToken}',
          // Replace with your actual token
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        _cartItems = (data['model'] as List)
            .map((json) => CartItemShow.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        print('Failed to load cart data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cart data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<CartItemShow>> updateCart(int cartItemId, int packId) async {
    logger.i({cartItemId, packId});
    try {
      final accessToken = await bearerToken.getAccessToken();
      final response = await http.put(
        Uri.parse(apiUrlUpdateCart),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'cartItemId': cartItemId,
          'packId': packId ?? 0,
          // Default to 0 if packId is null (buy option)
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        await viewCart();
        logger.i({_cartItems[0].packId});
        return _cartItems;
        calculateTotalPrice();// Refresh cart after update
      } else {
      return _cartItems;
        print('Failed to update cart: ${response.statusCode}');
      }
      notifyListeners();
    } catch (e) {
      return _cartItems;
      print('Error updating cart: $e');
    }
  }

  Future<void> addToCart(int bookId, bool ibuy, {int packId = 0}) async {
    try {
      final accessToken = await bearerToken.getAccessToken();
      final response = await http.post(
        Uri.parse(apiUrlAddToCart),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'bookId': bookId,
          'ibuy': ibuy,
          'packId': packId,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        await viewCart(); // Refresh cart after adding the item
      } else {
        print('Failed to add to cart: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  // Future<void> addToCart(int bookId, bool ibuy, {bookDetail.PackageShowbook? selectedPackage}) async {
  //   try {
  //     final accessToken = await bearerToken.getAccessToken();
  //     final response = await http.post(
  //       Uri.parse(apiUrlAddToCart),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         'bookId': bookId,
  //         'ibuy': ibuy,
  //         'selectedPackage': selectedPackage != null ? {
  //           'packageName': selectedPackage.packageName,
  //           'dayQuantity': selectedPackage.dayQuantity,
  //           'rentPrice': selectedPackage.rentPrice,
  //         } : null,
  //       }),
  //     );
  //
  //     if (response.statusCode == HttpStatus.ok) {
  //       await viewCart(); // Refresh cart after adding the item
  //     } else {
  //       print('Failed to add to cart: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error adding to cart: $e');
  //   }
  // }

  Future<void> removeFromCart(int bookId) async {
    try {
      final accessToken = await bearerToken.getAccessToken();
      final response = await http.delete(
        Uri.parse('$apiUrlRemoveFromCart/$bookId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        await viewCart(); // Refresh cart after removing the item
      } else {
        print('Failed to remove from cart: ${response.statusCode}');
      }
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }
}
