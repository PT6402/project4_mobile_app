import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testtem/DTO/AuthorDetailBook.dart';
import 'package:testtem/DTO/Authordetail.dart';
import 'package:testtem/DTO/BookFilter.dart';
import 'package:testtem/DTO/Category.dart';
import 'package:testtem/DTO/PaginatedBookStore.dart';
import 'package:testtem/DTO/Publisherdetail.dart';
import 'package:testtem/DTO/TopBuy.dart';
import 'package:testtem/DTO/TopLike.dart';
import 'package:testtem/DTO/NewRelease.dart';
import 'package:testtem/DTO/BookDetail.dart';
import 'package:testtem/core/constants/constant_url.dart';

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce({required this.delay});

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}

class BookProvider with ChangeNotifier {
  final String apiUrlLike = "${urlServer}/api/v1/statistics/toplike";
  final String apiUrlBuy = "${urlServer}/api/v1/statistics/topbuy";
  final String apiUrlNew = "${urlServer}/api/v1/statistics/top4";
  final String apiUrlBookDetail = "${urlServer}/api/v1/book/showone";
  final String apiUrlBookStore = "${urlServer}/api/v1/book/showpage";

  // API Search
  final String apiUrlSearchBook = "${urlServer}/api/v1/book/search";
  final String apiUrlSearchAuthor = "${urlServer}/api/v1/authors/search";
  final String apiUrlSearchPublisher = "${urlServer}/api/v1/publisher/search";
  //API getbooks
  final String apiUrlAuthorDetail = "${urlServer}/api/v1/authors/booksByAuthor";
  final String apiUrlPubDetail = "${urlServer}/api/v1/publisher/booksByPub";

  //API filter
  final String apiUrlFilterbook =
      "${urlServer}/api/v1/book/filterFlutter?page=1&limit=10";

  //API category
  final String apiUrlCate = "${urlServer}/api/v1/cate/userShow";

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

  //category

  List<Categoryshow> _cates = [];
  List<Categoryshow> get cates => _cates;

  Future<void> getCateList() async {
    try {
      final response = await http.get(Uri.parse(apiUrlCate));
      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        _cates = (data['model'] as List)
            .map((json) => Categoryshow.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching category: $e");
      throw Exception("Oops, something went wrong");
    }
  }

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

        final modelData = data['model'];
        if (modelData != null && modelData is Map<String, dynamic>) {
          final paglistData = modelData['paglist'];
          if (paglistData != null && paglistData is List) {
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

  // Search
  String _selectedCriteria = 'Book Name';
  String _query = '';

  List<AuthorDetailBook> _searchResults = [];

  final Debounce _debounce = Debounce(delay: Duration(milliseconds: 500));

  String get selectedCriteria => _selectedCriteria;

  List<AuthorDetailBook> get searchResults => _searchResults;

  void search(String query) {
    _query = query;

    _debounce(() {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    String url;
    switch (_selectedCriteria) {
      case 'Author Name':
        url = '${apiUrlSearchAuthor}?name=$query';
        break;
      case 'Publisher':
        url = '${apiUrlSearchPublisher}?name=$query';
        break;
      default:
        url = '${apiUrlSearchBook}?name=$query';
        break;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);

        _searchResults = (data['model'] as List<dynamic>?)
                ?.map(
                    (e) => AuthorDetailBook.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
        print("Book results: $_searchResults");
        notifyListeners();
      } else {
        print('Failed to load search results: ${response.statusCode}');
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      print("Error searching: $e");
      throw Exception("Failed to search");
    }
  }

  void updateCriteria(String newCriteria) {
    _selectedCriteria = newCriteria;
    _query = ''; // Clear the query when criteria change
    _searchResults.clear(); // Clear search results
    notifyListeners();
  }

  //Author detail
  AuthorDetail? _authorDetail;

  AuthorDetail? get authorDetail => _authorDetail;

  Future<void> getAuthorDetail(int authorId) async {
    print('Fetching details for authorId: $authorId');
    try {
      final response =
          await http.get(Uri.parse('${apiUrlAuthorDetail}?authorId=$authorId'));

      if (response.statusCode == HttpStatus.ok) {
        final responseData = json.decode(response.body);
        final authorDetailJson = responseData['model'];
        if (authorDetailJson != null) {
          _authorDetail = AuthorDetail.fromJson(authorDetailJson);
          notifyListeners();
        } else {
          print('Author detail not found in response.');
        }
      } else {
        print('Failed to load author detail: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching author detail: $e");
      throw Exception("Failed to load author detail");
    }
  }

  //Publisher detail
  PublisherDetail? _publisherDetail;
  PublisherDetail? get publisherDetail => _publisherDetail;

  Future<void> getPubDetail(int pubId) async {
    try {
      final response =
          await http.get(Uri.parse('${apiUrlPubDetail}?pubId=$pubId'));
      if (response.statusCode == HttpStatus.ok) {
        final responseData = json.decode(response.body);

        final publishDetailJson = responseData['model'];
        if (publishDetailJson != null) {
          _publisherDetail = PublisherDetail.fromJson(publishDetailJson);
          notifyListeners();
        } else {
          print("Publisher detail not found in response");
        }
      } else {
        print('Failed to load publisher detail: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching author detail: $e");
      throw Exception("Failed to load author detail");
    }
  }

//filter boook
//  List<BookStore> _listBooks = [];
//   List<BookStore> get listBooks => _listBooks;

  // Khởi tạo giá trị mặc định
//  int _defaultStartRange = 0;
// int _defaultEndRange = 1000;
// String _defaultCategory = 'All Categories';
// double _defaultRating = 0.0;

// Sử dụng biến nullable để lưu các giá trị lọc
  int? _startRange;
  int? _endRange;
  String? _selectedCategory;
  double? _selectedRating;
  bool _noBooksFound = false;

  Future<void> setFilters(double startRange, double endRange, String category, double rating) async {
  // Giá trị mặc định cho các tham số lọc
  const _defaultStartRange = 0.0;
  const _defaultEndRange = 1000.0;
  const _defaultCategory = 'All Categories';
  const _defaultRating = 0.0;

  // Xử lý giá trị cho các tham số lọc
  String? startRangeParam;
  String? endRangeParam;

  if (startRange == _defaultStartRange && endRange == _defaultEndRange) {
    // Nếu cả hai giá trị không thay đổi thì là null
    startRangeParam = null;
    endRangeParam = null;
  } else {
    // Nếu một trong hai giá trị thay đổi, giá trị còn lại sẽ lấy giá trị mặc định
    if (startRange != _defaultStartRange) {
      startRangeParam = startRange.toInt().toString();
      endRangeParam = _defaultEndRange.toInt().toString();
    } else if (endRange != _defaultEndRange) {
      endRangeParam = endRange.toInt().toString();
      startRangeParam = _defaultStartRange.toInt().toString();
    }
  }

  // Xử lý category
  String? categoryId;
  if (category != _defaultCategory) {
    final categoryItem = _cates.firstWhere(
      (cate) => cate.name == category,
      
    );

    // Kiểm tra và gán giá trị ID nếu tìm thấy categoryItem
    if (categoryItem != null) {
      categoryId = categoryItem.id.toString();
    }
  }

  final ratingParam = (rating == _defaultRating) ? null : rating.toString();

  print("object: $startRangeParam, $endRangeParam, $categoryId, $ratingParam");

  // Đặt lại phân trang
  _currentPage = 1;
  _listbooks.clear(); // Xóa các kết quả trước đó

  // Xây dựng URL với các tham số lọc
  final uri = Uri.parse(
    '$apiUrlFilterbook&from=${startRangeParam ?? ''}&to=${endRangeParam ?? ''}&list=${categoryId ?? ''}&rating=${ratingParam ?? ''}'
  );

  try {
    final response = await http.post(uri);

    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body);
      final model = data['model'] as Map<String, dynamic>? ?? {};
      final totalPage = model['totalPage'] as int? ?? 0;
      final pagList = model['paglist'] as List<dynamic>? ?? [];

      // print('PagList: ${pagList}');

      _listbooks = pagList.map((book) {
        // print('Book Data: ${book}'); 
        return BookStore.fromJson(book);
      }).toList();
      _noBooksFound=_listbooks.isEmpty;
      
      _hasMore = _currentPage < totalPage;
      _currentPage++;
      notifyListeners();
    } else {
      throw Exception('Không thể tải sách');
    }
  } catch (e) {
    print(e);
    throw Exception('Lỗi khi áp dụng bộ lọc');
  }
}
}