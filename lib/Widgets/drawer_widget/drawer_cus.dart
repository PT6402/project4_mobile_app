import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:testtem/Widgets/drawer_widget/infor_card.dart';
import 'package:testtem/Widgets/drawer_widget/side_menu_tile.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_state.dart';

class DrawerCus extends StatefulWidget {
  const DrawerCus({super.key});

  @override
  State<DrawerCus> createState() => _DrawerCusState();
}

class _DrawerCusState extends State<DrawerCus> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: 288,
            color: Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.user != null)
                  InforCard(
                    name: state.user!.name!,
                    email: state.user!.email!,
                  ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                //     child: Text(
                //       "browser".toUpperCase(),
                //       style: Theme.of(context)
                //           .textTheme
                //           .titleMedium!
                //           .copyWith(color: Colors.white70),
                //     ),
                //   ),
                //   SideMenuTile(
                //     name: "Home",
                //     icon: IconlyLight.home,
                //     isActive: false,
                //     press: () {},
                //   ),
                //   SideMenuTile(
                //     name: "Home",
                //     icon: IconlyLight.home,
                //     isActive: false,
                //     press: () {},
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                //     child: Text(
                //       "browser".toUpperCase(),
                //       style: Theme.of(context)
                //           .textTheme
                //           .titleMedium!
                //           .copyWith(color: Colors.white70),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
