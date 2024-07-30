import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_state.dart';

class AppBarCus extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  const AppBarCus({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AppBar(
          title: Transform.translate(
            offset: const Offset(-20, 0),
            child: Text("The book shelf",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15)),
          ),
          actions: [
            GestureDetector(
                onTap: () => context.pushNamed("search"),
                child: const Icon(IconlyLight.search)),
            const SizedBox(
              width: 10,
            ),
            state.user != null
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed("wishlist");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                          ),
                          child: const Row(
                            children: [Icon(IconlyLight.heart), Text("1")],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                : const SizedBox(),
            state.user == null
                ? const SizedBox()
                : GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                        child: const Row(
                          children: [Icon(IconlyLight.notification), Text("1")],
                        )),
                    onTap: () {},
                  ),
            const SizedBox(
              width: 10,
            ),
          ],
        );
      },
    );
  }
}
