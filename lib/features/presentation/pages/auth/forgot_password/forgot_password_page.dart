import 'package:flutter/material.dart';
import 'package:testtem/features/presentation/pages/auth/forgot_password/widgets/body_forgot.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const BodyForgot(),
    );
  }
}
