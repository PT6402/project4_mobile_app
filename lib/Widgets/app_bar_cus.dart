import 'package:flutter/material.dart';

class AppBarCus extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  const AppBarCus({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("app",
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15)),
    );
  }
}
