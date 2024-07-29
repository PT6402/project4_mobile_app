import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:testtem/Providers/BookProvider.dart';

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // int _selectedIndex = 0;
  // void _goToBrach(int index, BuildContext context) {
  //   List listRoute = widget.navigationShell.shellRouteContext.route.routes;
  //   for (int i = 0; i < listRoute.length; i++) {
  //     if (i == index) {
  //       context.replaceNamed(listRoute[i].name);
  //     }
  //   }
  // }

  // _onTapNav(index, BuildContext context) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   _goToBrach(_selectedIndex, context);
  // }

  _buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: widget.navigationShell,
    );
  }

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
      // appBar: const AppBarCus(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 3) {
            Navigator.pushNamed(context, '/wishlist');
          } else if (index == 4) {
            _showMoreMenu(context);
          } else {
            // Handle other navigation
          }
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode),
            label: 'Reading',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
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

  void _showMoreMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTRB(
          overlay.size.width - 150,
          overlay.size.height - 250,
          0,
          0,
        ),
        Offset.zero & overlay.size,
      ),
      items: const [
        PopupMenuItem<String>(
          value: 'cart',
          child: ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'order',
          child: ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Order'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'about_us',
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
          ),
        ),
      ],
    ).then((value) {
      // Handle menu item selection here
      if (value == 'cart') {
        // Navigate to cart
      } else if (value == 'order') {
        // Navigate to order
      } else if (value == 'about_us') {
        // Navigate to about us
      }
    });
  }
}
