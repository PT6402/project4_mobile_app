import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
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
          title: Row(
            children: [
              Text("The book shelf",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15)),
            ],
          ),
          actions: [
            const Icon(IconlyLight.search),
            const SizedBox(
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: const Row(
                children: [Icon(IconlyLight.bag), Text("1")],
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                child: const Row(
                  children: [Icon(IconlyLight.notification), Text("1")],
                )),
            const SizedBox(
              width: 5,
            ),
            state.user == null
                ? GestureDetector(
                    child: const Icon(IconlyLight.login),
                    onTap: () => context.pushNamed("login"),
                  )
                : GestureDetector(
                    child: const Icon(IconlyLight.logout),
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(LogoutUser(context));
                    },
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
