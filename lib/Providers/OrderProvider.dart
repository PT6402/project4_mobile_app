import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testtem/DTO/Order.dart';
import 'package:http/http.dart' as http;
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';

class OrderProvider with ChangeNotifier {
  final StorageToken bareToken;
  final String apiUrlOrderShow = "${urlServer}/api/v1/orders";
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
        print("Response body: ${response.body}");
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
}
