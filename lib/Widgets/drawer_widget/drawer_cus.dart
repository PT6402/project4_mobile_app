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
  void _showAboutUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.66,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'E- Bookshelf',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('- Version: 5.4.3.3',
                              style: TextStyle(fontSize: 15)),
                          Text('- Liscene: 0123987233 KHDK HCMC',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 10),
                          Text(
                              'Address: 686 Xo Viet Nghe Tinh,Ward 25, Binh Thanh, HCMC',
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/images/ebook.jpeg',
                      height: 200,
                      width: 300,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.withOpacity(0.5),  // Màu nền của nút
                        foregroundColor: Colors.white, // Màu chữ của nút
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical:
                                12.0), // Kích thước padding để làm cho nút rộng ra
                        minimumSize:
                            Size(150, 40), // Kích thước tối thiểu của nút
                      ),
                      child: Text('Confirm',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return SafeArea(
        child: Container(
          height: double.infinity,
          margin: const EdgeInsets.only(bottom: 20, left: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.9),
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
                            name: "Order History",
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
                                Navigator.pop(context);
                                _showAboutUsDialog(context);
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
                          Navigator.pop(context);
                          _showAboutUsDialog(context);
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

