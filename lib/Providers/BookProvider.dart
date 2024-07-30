import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:testtem/DTO/PaginatedBookStore.dart';
import 'package:testtem/DTO/TopBuy.dart';
import 'package:testtem/DTO/TopLike.dart';
import 'package:testtem/DTO/NewRelease.dart';
import 'package:testtem/DTO/BookDetail.dart';

class BookProvider with ChangeNotifier {

  final String apiUrlLike =
      "http://192.168.1.9:9090/api/v1/statistics/toplike";
  final String apiUrlBuy = "http://192.168.1.9:9090/api/v1/statistics/topbuy";
  final String apiUrlNew = "http://192.168.1.9:9090/api/v1/statistics/top4";
  final String apiUrlBookDetail =
      "http://192.168.1.9:9090/api/v1/book/showone";
  final String apiUrlBookStore =
      "http://192.168.1.9:9090/api/v1/book/showpage";

  List<TopLike> _books = [];
  List<TopLike> get books => _books;

  List<TopBuy> _BBooks = [];
  List<TopBuy> get bBooks => _BBooks;

  List<NewRelease> _NBooks = [];
  List<NewRelease> get nBooks => _NBooks;

  BookDetail? _bookDetail;
  BookDetail? get bookDetail => _bookDetail;

  bool _isLoading = false;
  bool _hasMore = true;
  List<BookStore> _listbooks = [];
  int _currentPage = 0; // Track the current page

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  List<BookStore> get Listbooks => _listbooks;

  Future<void> getTopLike() async {
    try {
      final response = await http.get(Uri.parse(apiUrlLike));
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> data = json.decode(response.body);
        _books = data.map((json) => TopLike.fromJson(json)).toList();
        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching top likes: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> getTopBuy() async {
    try {
      final response = await http.get(Uri.parse(apiUrlBuy));
      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        _BBooks = (data['model'] as List)
            .map((json) => TopBuy.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching top buys: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> getTopNew() async {
    try {
      final response = await http.get(Uri.parse(apiUrlNew));
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> data = json.decode(response.body);
        _NBooks = data.map((json) => NewRelease.fromJson(json)).toList();
        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching new releases: $e");
      throw Exception("Oops, something went wrong");
    }
  }

  Future<void> getBookDetail(int bookId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrlBookDetail/$bookId'));
      if (response.statusCode == HttpStatus.ok) {
        _bookDetail = BookDetail.fromJson(json.decode(response.body)['model']);
        notifyListeners();
      } else {
        print('Failed to load book detail: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching book detail: $e");
      throw Exception("Failed to load book detail");
    }
  }

 Future<void> getBookStore({int page = 1, int limit = 10}) async {
  if (_isLoading || !_hasMore) return;

  _isLoading = true;
  notifyListeners();

  try {
    final response =
        await http.get(Uri.parse('$apiUrlBookStore?page=$page&limit=$limit'));

    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body);

      // Kiểm tra chi tiết từng phần của dữ liệu JSON
      print("Raw JSON data: $data");

      final modelData = data['model'];
      if (modelData != null && modelData is Map<String, dynamic>) {
        print("Model data: $modelData");

        final paglistData = modelData['paglist'];
        if (paglistData != null && paglistData is List) {
          print("Paglist data: $paglistData");

          final List<BookStore> paginatedBooks = [];
          for (var item in paglistData) {
            if (item != null && item is Map<String, dynamic>) {
              try {
                paginatedBooks.add(BookStore.fromJson(item));
              } catch (e) {
                print('Error parsing item: $item, error: $e');
              }
            } else {
              print('Invalid item in paglist: $item');
            }
          }

          // Kiểm tra và cập nhật _hasMore
          if (paginatedBooks.isEmpty) {
            _hasMore = false;
          } else {
            _listbooks.addAll(paginatedBooks);
            _currentPage++;
            print("Parsed books: $paginatedBooks");
            print("Current book list: $_listbooks");

            // Nếu số lượng kết quả trả về ít hơn limit, có nghĩa là đã tải hết dữ liệu
            if (paginatedBooks.length < limit) {
              _hasMore = false;
            }
          }
        } else {
          _hasMore = false;
          print("Paglist is not a list or is empty");
        }
      } else {
        _hasMore = false;
        print("Model data is not a map or is null");
      }

      notifyListeners();
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching books: $e');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


}