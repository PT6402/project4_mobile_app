import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:testtem/Widgets/drawer_widget/infor_card.dart';
import 'package:testtem/Widgets/drawer_widget/side_menu_tile.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_state.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_button.dart';

class DrawerCus extends StatefulWidget {
  const DrawerCus({super.key});

  @override
  State<DrawerCus> createState() => _DrawerCusState();
}

class _DrawerCusState extends State<DrawerCus> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return SafeArea(
        child: Container(
          height: double.infinity,
          margin: const EdgeInsets.only(bottom: 20, left: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blueGrey[400]?.withOpacity(0.8),
          ),
          width: 288,
          child: state.user != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          InforCard(
                            name: state.user!.name!,
                            email: state.user!.email!,
                          ),
                          SideMenuTile(
                            name: "Order",
                            icon: IconlyLight.time_circle,
                            isActive: false,
                            press: () {
                              context.pushNamed("order");
                            },
                          ),
                          SideMenuTile(
                            name: "Change password",
                            icon: IconlyLight.password,
                            isActive: false,
                            press: () {
                              context.pushNamed("changePassword");
                            },
                          ),
                          Center(
                            child: SideMenuTile(
                              name: "About us",
                              icon: IconlyLight.user_1,
                              isActive: false,
                              press: () {
                                context.pushNamed("aboutUs");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          // border: Border.all(width: 1, color: Colors.white60),
                          borderRadius: BorderRadius.circular(10)),
                      child: RoudedButton(
                        color: Colors.blueGrey,
                        textColor: Colors.white,
                        press: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(LogoutUser(context));
                          Navigator.pop(context);
                        },
                        text: "Logout",
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[600],
                            // border: Border.all(width: 1, color: Colors.white60),
                            borderRadius: BorderRadius.circular(10)),
                        child: RoudedButton(
                          color: Colors.blueGrey,
                          textColor: Colors.white,
                          press: () {
                            context.pushNamed("login");
                          },
                          text: "Login",
                        ),
                      ),
                      SideMenuTile(
                        name: "About us",
                        icon: IconlyLight.user_1,
                        isActive: false,
                        press: () {
                          context.pushNamed("aboutUs");
                        },
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
