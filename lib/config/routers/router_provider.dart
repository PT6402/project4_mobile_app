import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:testtem/Screens/BookDetailPage.dart';
import 'package:testtem/Screens/HomePage.dart';
import 'package:testtem/Screens/Wishlist.dart';

import 'package:testtem/Screens/author_page.dart';
import 'package:testtem/Screens/cart_page.dart';
import 'package:testtem/Screens/my_book_page.dart';
import 'package:testtem/Screens/order_page.dart';
import 'package:testtem/Screens/publisher_page.dart';
import 'package:testtem/Screens/read_page.dart';
import 'package:testtem/Screens/search_page.dart';
import 'package:testtem/Screens/store_page.dart';
import 'package:testtem/features/presentation/pages/auth/authenticate/login_page.dart';
import 'package:testtem/features/presentation/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:testtem/features/presentation/pages/auth/register_password/register_page.dart';
import 'package:testtem/features/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:testtem/main_wrapper.dart';

class RouterProvider {
  RouterProvider._();
  static final _rootNavigationKey = GlobalKey<NavigatorState>();
  static final _rootNavigationHome =
      GlobalKey<NavigatorState>(debugLabel: "shellHome");
  static final _rootNavigationStore =
      GlobalKey<NavigatorState>(debugLabel: "shellStore");
  static final _rootNavigationMybook =
      GlobalKey<NavigatorState>(debugLabel: "shellMyBook");
  static final _rootNavigationCart =
      GlobalKey<NavigatorState>(debugLabel: "shellCart");
  static String initR = "/home";
  static final GoRouter router = GoRouter(
      initialLocation: initR,
      navigatorKey: _rootNavigationKey,
      debugLogDiagnostics: true,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainWrapper(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(navigatorKey: _rootNavigationHome, routes: [
              GoRoute(
                path: "/home",
                name: "home",
                builder: (context, state) {
                  return HomePage(
                    key: state.pageKey,
                  );
                },
              )
            ]),
            StatefulShellBranch(navigatorKey: _rootNavigationStore, routes: [
              GoRoute(
                path: "/product",
                name: "product",
                builder: (context, state) {
                  return StorePage(
                    // key: state.pageKey,
                  );
                },
              )
            ]),
            StatefulShellBranch(navigatorKey: _rootNavigationMybook, routes: [
              GoRoute(
                path: "/myBook",
                name: "myBook",
                builder: (context, state) {
                  return MyBookPage(
                    key: state.pageKey,
                  );
                },
              )
            ]),
            StatefulShellBranch(navigatorKey: _rootNavigationCart, routes: [
              GoRoute(
                path: "/cart",
                name: "cart",
                builder: (context, state) {
                  return CartPage(
                    key: state.pageKey,
                  );
                },
              )
            ]),
            // StatefulShellBranch(
            //     initialLocation: "/login",
            //     navigatorKey: _rootNavigationAuth,
            //     routes: []),
          ],
        ),
        GoRoute(
          path: "/login",
          name: "login",
          builder: (context, state) {
            return LoginPage(
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
            path: "/register",
            name: "register",
            builder: (context, state) {
              return RegisterPage(
                key: state.pageKey,
              );
            }),
        GoRoute(
            path: "/forgot-password",
            name: "forgotPassword",
            builder: (context, state) {
              return ForgotPasswordPage(
                key: state.pageKey,
              );
            }),
        GoRoute(
            path: "/reset-password/:isCode",
            name: "resetPassword",
            builder: (context, state) {
              final isCode = state.pathParameters["isCode"]!;
              return ResetPasswordPage(
                checkCode: bool.parse(isCode),
                key: state.pageKey,
              );
            }),
        GoRoute(
          path: "/bookDetail/:bookId",
          name: "bookDetail",
          builder: (context, state) {
            final bookId = state.pathParameters["bookId"]!;
            return BookDetailPage(
                key: state.pageKey, bookId: int.parse(bookId));
          },
        ),
        GoRoute(
          path: "/authorDetail/:authorId",
          name: "authorDetail",
          builder: (context, state) {
            final authorId = state.pathParameters["authorId"]!;
            return AuthorPage(
                key: state.pageKey, authorId: int.parse(authorId));
          },
        ),
        GoRoute(
          path: "/publisherDetail/:pubId",
          name: "publisherDetail",
          builder: (context, state) {
            final pubId = state.pathParameters["pubId"]!;
            return PublisherPage(
                key: state.pageKey, pubId: int.parse(pubId));
          },
        ),
        GoRoute(
          path: "/search",
          name: "search",
          builder: (context, state) {
            return SearchPage(key: state.pageKey);
          },
        ),
  
        GoRoute(
          path: "/order",
          name: "order",
          builder: (context, state) {
            return OrderPage(key: state.pageKey);
          },
        ),
        GoRoute(
          path: "/wishlist",
          name: "wishlist",
          builder: (context, state) {
            return WishlistScreen(key: state.pageKey);
          },
        ),
        GoRoute(
          path: "/readpage",
          name: "readpage",
          builder: (context, state) {
            final bookId=state.pathParameters["bookId"]!;
            return ReadPage(
              key: state.pageKey,
              bookId: int.parse(bookId),);
          },
        ),
      ]);
}
