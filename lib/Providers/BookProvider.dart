import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:testtem/DTO/BookDetail.dart';
import 'package:testtem/DTO/NewRelease.dart';
import 'package:testtem/DTO/TopBuy.dart';
import 'package:testtem/DTO/TopLike.dart';
import 'package:http/http.dart' as http;

class BookProvider with ChangeNotifier {
  final String apiUrllike =
      "http://192.168.1.14:9090/api/v1/statistics/toplike";
  final String apiUrlbuy = "http://192.168.1.14:9090/api/v1/statistics/topbuy";
  final String apiUrlnew = "http://192.168.1.14:9090/api/v1/statistics/top4";
  final String apiUrlBookDetail =
      "http://192.168.1.14:9090/api/v1/book/showone";

  List<TopLike> _books = [];
  List<TopLike> get books => _books;

  List<TopBuy> _Bbooks = [];
  List<TopBuy> get Bbooks => _Bbooks;

  List<NewRelease> _Nbooks = [];
  List<NewRelease> get Nbooks => _Nbooks;

  BookDetail? _bookDetail;
  BookDetail? get bookDetail => _bookDetail;

  Future<void> getTopLike() async {
    try {
      final response = await http.get(Uri.parse(apiUrllike));
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> extractData = json.decode(response.body);

        _books = extractData
            .map((data) => TopLike.fromJson(data as Map<String, dynamic>))
            .toList();

        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching api products: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> getTopBuy() async {
    try {
      final response = await http.get(Uri.parse(apiUrlbuy));
      if (response.statusCode == HttpStatus.ok) {
        final extractData = json.decode(response.body);
        List<dynamic> data = extractData["model"];
        // print('Response Data: $data'); // Log response data
        _Bbooks = data.map((pro) => TopBuy.fromJson(pro)).toList();
        // print('BBooks: $_Bbooks'); // Log parsed books
        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching api products: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> getTopNew() async {
    try {
      final response = await http.get(Uri.parse(apiUrlnew));
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> extractData = json.decode(response.body);
        print('Response Data: $extractData'); // Log response data
        _Nbooks = extractData
            .map((data) => NewRelease.fromJson(data as Map<String, dynamic>))
            .toList();
        print('NBooks: $_Nbooks'); // Log parsed books
        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching api products: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> getBookDetail(int bookId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrlBookDetail/$bookId'));
      if (response.statusCode == HttpStatus.ok) {
        _bookDetail = BookDetail.fromJson(json.decode(response.body)['model']);
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching book detail: $e");
      throw Exception("Failed to load book detail");
    }
  }
}
