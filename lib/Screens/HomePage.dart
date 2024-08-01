import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/BookProvider.dart';
import 'package:testtem/Widgets/BookListBuy.dart';
import 'package:testtem/Widgets/BookListLike.dart';
import 'package:testtem/Widgets/BookSlider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final bookProvider = Provider.of<BookProvider>(context);
      bookProvider.getTopLike();
      bookProvider.getTopBuy();
      bookProvider.getTopNew();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<BookProvider>(
                builder: (context, bookProvider, child) {
                  return BookSlider(
                      title: 'New Release', books: bookProvider.nBooks);
                },
              ),
              Consumer<BookProvider>(
                builder: (context, bookProvider, child) {
                  return BookListLike(
                      title: 'Most Liked Books', books: bookProvider.books);
                },
              ),
              Consumer<BookProvider>(
                builder: (context, bookProvider, child) {
                  return BookListBuy(
                      title: 'Most Purchased Books', books: bookProvider.bBooks);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Books'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(25.0, kToolbarHeight, 0.0, 0.0),
      items: const [
        PopupMenuItem<String>(
          value: 'login',
          child: Text('Login'),
        ),
        PopupMenuItem<String>(
          value: 'register',
          child: Text('Register'),
        ),
        PopupMenuItem<String>(
          value: 'forgotpass',
          child: Text('Forgot Password'),
        ),
      ],
    ).then((value) {
      // Handle menu item selection here
      if (value == 'login') {
        // Navigate to login
      } else if (value == 'register') {
        // Navigate to register
      } else if (value == 'forgotpass') {
        // Navigate to forgot password
      }
    });
  }
}
