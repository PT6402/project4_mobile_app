import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testtem/DTO/Order.dart';
import 'package:http/http.dart' as http;
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';

class OrderProvider with ChangeNotifier {
  final StorageToken bareToken;
  final String apiUrlOrderShow = "${urlServer}/api/v1/orders/Fget";
  final String apiUrlReview = "${urlServer}/api/v1/reviews/F";
  OrderProvider(this.bareToken);

  List<Order> _orderlist = [];
  List<Order> get orderlist => _orderlist;

  Future<void> getOrder() async {
    try {
      final token = await bareToken.getAccessToken();
      final response = await http.get(
        Uri.parse(apiUrlOrderShow),
        headers: {'Authorization': 'Bearer $token!'},
      );
      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        if (data['model'] is List) {
          _orderlist = (data['model'] as List)
              .map((json) => Order.fromJson(json))
              .toList();
          notifyListeners();
          print("list.....:$_orderlist");
        } else {
          print("Unexpected JSON structure: ${data['model']}");
          throw Exception("Unexpected JSON structure");
        }
      } else {
        print("HTTP error: ${response.statusCode}");
        throw Exception("HTTP error");
      }
    } catch (e) {
      print("Error show orderlist: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  // Create new review and return the message
  Future<String> createReview(int bookId, double rating, String content) async {
  try {
    final token = await bareToken.getAccessToken();
    final response = await http.post(
      Uri.parse(apiUrlReview),
      headers: {
        'Authorization': 'Bearer $token!',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'content': content,
        'rating': rating.toInt(),
        'bookId': bookId,
      }),
    );

    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body);
      print("Response body: ${response.body}");

      if (data['status']) {
        print("Review created successfully: ${data['message']}");
        // Làm mới danh sách đơn hàng sau khi thêm đánh giá
        await getOrder();
        return data['message'];
      } else {
        throw Exception("Failed to create review: ${data['message']}");
      }
    } else {
      throw Exception("HTTP error: ${response.statusCode}");
    }
  } catch (e) {
    print("Error create review: $e");
    throw Exception("Oops, something went wrong");
  }
}

}
