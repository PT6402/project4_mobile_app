import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testtem/DTO/ImageBook.dart';
import 'package:http/http.dart' as http;
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';

class ReadProvider with ChangeNotifier {
  //Token
  final StorageToken bareToken;
  ReadProvider(this.bareToken);
//API
  final String apiGetInit = "${urlServer}/api/v1/read";

//Variable
//10 trang luc dau
  List<ImageBook> _imageInit = [];
  List<ImageBook> get imageInit => _imageInit;



  Future<void> getInit(int bookId) async {
    try {
      final token = await bareToken.getAccessToken();
      final response = await http.get(Uri.parse('$apiGetInit/$bookId'),
          headers: {'Authorization': 'Bearer $token!'});

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        print("object: $data");

        // Kiểm tra cấu trúc JSON và trích xuất dữ liệu đúng
        if (data['model'] != null && data['model']['list'] != null && data['model']['list'] is List) {
          _imageInit = (data['model']['list'] as List)
              .map((json) => ImageBook.fromJson(json))
              .toList();
          notifyListeners();
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
