import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testtem/DTO/Mybook.dart';
import 'package:http/http.dart' as http;
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/core/secure_storage/storage_token.dart';

class MyBookProvider with ChangeNotifier {
  final StorageToken bareToken;
  final String apiUrlMybookShow = "${urlServer}/api/v1/mybook";

  MyBookProvider(this.bareToken);

  List<MyBook> _MBlist = [];
  List<MyBook> get MBlist => _MBlist;

  Future<void> getMB() async {
    try {
      final token = await bareToken.getAccessToken();
     
      final response = await http.get(
        Uri.parse(apiUrlMybookShow),
        headers: {'Authorization': 'Bearer $token!'},
      );
      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        print("test: $data");
        if (data['model'] is List) {
          _MBlist = (data['model'] as List)
              .map((json) => MyBook.fromJson(json))
              .toList();
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error show orderlist: $e");
      throw Exception("Oops, something went wrong");
    }
  }
}
