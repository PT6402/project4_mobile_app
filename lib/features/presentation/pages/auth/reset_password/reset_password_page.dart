import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
// import 'package:testtem/features/presentation/bloc/auth/auth_state.dart';
import 'package:testtem/features/presentation/pages/auth/reset_password/widgets/background_reset.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundReset(
        child: SingleChildScrollView(
      child: Center(
        child: Container(
          width: size.width,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          // child: BlocBuilder<AuthBloc, AuthState>(
          //   builder: (_, state) {
          //     if(state is )
          //   }
          // )
        ),
      ),
    ));
  }
}
