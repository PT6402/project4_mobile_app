import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:testtem/Screens/BookDetailPage.dart';
import 'package:testtem/Screens/HomePage.dart';
import 'package:testtem/main_wrapper.dart';

class RouterProvider {
  RouterProvider._();
  static final _rootNavigationKey = GlobalKey<NavigatorState>();
  static final _rootNavigationHome =
      GlobalKey<NavigatorState>(debugLabel: "shellHome");
  static final _rootNavigationWishlist =
      GlobalKey<NavigatorState>(debugLabel: "shellWishlist");
  static final _rootNavigationAccount =
      GlobalKey<NavigatorState>(debugLabel: "shellAccount");
  static final _rootNavigationAuth =
      GlobalKey<NavigatorState>(debugLabel: "shellAuth");
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
          ],
        ),
        GoRoute(
          path: "/bookDetail",
          name: "bookDetail",
          builder: (context, state) {
            return BookDetailPage(
                key: state.pageKey,
                bookId: ModalRoute.of(context)!.settings.arguments as int);
          },
        )
      ]);
}
