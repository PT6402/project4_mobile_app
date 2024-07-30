import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testtem/Widgets/app_bar_cus.dart';
import 'package:testtem/Widgets/bottom_navigation_bar_cus.dart';
import 'package:testtem/Widgets/drawer_widget/drawer_cus.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_state.dart';

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  void _goToBrach(int index, BuildContext context) {
    List listRoute = widget.navigationShell.shellRouteContext.route.routes;
    for (int i = 0; i < listRoute.length; i++) {
      if (i == index) {
        context.replaceNamed(listRoute[i].name);
      }
    }
  }

  _onTapNav(index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });
    _goToBrach(_selectedIndex, context);
  }

  _buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: widget.navigationShell,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: const AppBarCus(),
      body: _buildBody(),
      bottomNavigationBar: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoggedInState || state is GuestUserState) {
                _selectedIndex = 0;
                context.goNamed("home");
              }
            },
          )
        ],
        child: BottomNavigationBarCus(
          selectedIndex: _selectedIndex,
          onTap: (index) => _onTapNav(index, context),
        ),
      ),
      drawer: const DrawerCus(),
    );
  }
}
