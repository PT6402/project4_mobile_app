import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:testtem/DTO/WishlistShow.dart';
import 'package:testtem/core/constants/constant_url.dart';
import 'package:http/http.dart' as http;
import 'package:testtem/core/secure_storage/storage_token.dart';

class WishListProvider with ChangeNotifier {
  final String apiUrlWishShow = "${urlServer}/api/v1/wishlist";
  final String apiUrlWishCheck = "${urlServer}/api/v1/wishlist/check";
  final StorageToken bareToken;
  WishListProvider(this.bareToken);

  List<Wishlistshow> _listshow = [];
  List<Wishlistshow> get listshow => _listshow;

  Future<void> getWishlist() async {
    try {
      final token = await bareToken.getAccessToken();
      final response = await http.get(Uri.parse(apiUrlWishShow), headers: {'Authorization': 'Bearer $token!'});

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        _listshow = (data['model'] as List).map((json) => Wishlistshow.fromJson(json)).toList();
        notifyListeners();
        print("object: $_listshow");
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching wishlist: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> deleteWish(int bookid) async {
    try {
      final token = await bareToken.getAccessToken();
      await http.delete(Uri.parse('${apiUrlWishShow}/${bookid}'), headers: {'Authorization': 'Bearer $token!'});
    } catch (e) {
      print("Error delete wishlist: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> addWish(int bookId) async {
    try {
      final token = await bareToken.getAccessToken();
      await http.post(Uri.parse('${apiUrlWishShow}?bookid=$bookId'), headers: {'Authorization': 'Bearer $token!'});
    } catch (e) {
      print("Error add wishlist: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<bool> checkStatus(int bookId) async {
    try {
      final token = await bareToken.getAccessToken();
      final response = await http.get(Uri.parse('${apiUrlWishCheck}?bookId=$bookId'), headers: {'Authorization': 'Bearer $token!'});

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
         bool modelStatus = data['model'] ?? false;
      return modelStatus;
      } else {
        print("Failed to check status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error check wishlist: $e");
      return false;
    }
  }
}
