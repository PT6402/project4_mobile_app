import 'package:flutter/material.dart';
import 'package:testtem/features/presentation/pages/auth/reset_password/widgets/background_reset.dart';
import 'package:testtem/features/presentation/pages/auth/reset_password/widgets/form_change_pass.dart';
import 'package:testtem/features/presentation/pages/auth/reset_password/widgets/form_otp.dart';

class ResetPasswordPage extends StatelessWidget {
  final bool checkCode;
  const ResetPasswordPage({super.key, required this.checkCode});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: BackgroundReset(
          child: SingleChildScrollView(
        child: Center(
          child: Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: (checkCode) ? const FormOtp() : const FormChangePass()),
        ),
      )),
    );
    ;
  }
}
