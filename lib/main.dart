import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/BookProvider.dart';
import 'package:testtem/Screens/BookDetailPage.dart';
import 'package:testtem/Screens/HomePage.dart';
import 'package:testtem/Screens/Wishlist.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/wishlist': (context) => WishlistScreen(),
        '/bookDetail': (context) => BookDetailPage(
            bookId: ModalRoute.of(context)!.settings.arguments as int),
      },
    );
  }
}
